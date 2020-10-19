// Interactor
// WeatherInteractor [Action]

import UIKit
import CoreLocation

// MARK: - Interactor Protocol
protocol WeatherInteractorProtocol {
    func askLocationAutorization()
    func getWeatherByCurentLocation()
    func importDataCity(completionHandler: @escaping ()->Void)
}

// MARK: - Data Store Interactor Protocol
protocol WeatherInteractorDataStoreProtocol {
    var datasStoreWeatherInteractor: [Weather]? {get}
}

// MARK: - Interactor implementation ask and manage
class WeatherInteractor: WeatherInteractorProtocol, WeatherInteractorDataStoreProtocol {
    var presenter: WeatherPresenterProtocol?
    var datasStoreWeatherInteractor: [Weather]?
    var weatherWorker = WeatherWorker() // Worker communicate with WeatherInteractor
    
    init() {
        print("  L\(#line) [🆔\(type(of: self))  🆔\(#function) ] ")
        weatherWorker.weatherApi.locationManager.delegate = self
//        weatherWorker.weatherApi.locationManager.delegate = self // setup delegate to get back informations from WeatherApi about Location permission
    }
    
    // MARK: - Action
    /** Permission location : ask the permission to activate location. */
    func askLocationAutorization() {
        weatherWorker.weatherApi.askLocationAutorization()
    }
    
    /** get the information to show the weather with the current location. */
    func getWeatherByCurentLocation() {
        // recuperation des coordonnée

        weatherWorker.weatherApi.getWeatherByCurrentLocation { (resultWeather) in
            DispatchQueue.main.async {
                if let resultWeather = resultWeather {
                    // if data here presentethe weather
                    self.presenter?.presentWeather(data: resultWeather)
                    self.presenter?.isPresentViewConnectionNotAvailable(false) // [hide] view by default hide but shown
                } else {
                    // present autre chose
                    print("██░░░ L\(#line) 🚧🚧 getWeatherByCurrentLocation : CONNECTION non disponible 🚧🚧 [ \(type(of: self))  \(#function) ]")
                    self.presenter?.isPresentViewConnectionNotAvailable(true)// [show] view by default hide
                }

            }

        }
        
    }
    
    /** import data city from json. */
    func importDataCity(completionHandler: @escaping ()->Void) {
        importDataCity()
        completionHandler()
    }
    
    // MARK: - File Private
    /** import data form json. */
    fileprivate func importDataCity() {
        // read  SettingEntity field isDownloaded in data base.
        var resultFetch :SettingEntity! = nil
        
        // Create a flag in CoreData to know if user already or not import the cities.
        weatherWorker.weatherCoreData.readSettingIsDownloaded { (resultArray) in
            guard let result = resultArray?.first else { return }
            resultFetch = result
        }
        
        if true {
//        if resultFetch == nil {
            // delete and create setting row
            weatherWorker.weatherCoreData.deleteAllSettingEntity()
            weatherWorker.weatherCoreData.deleteAllCityEntity() // Clean the data base to avoid duplication.
            weatherWorker.weatherCoreData.createSettingRow() // Create new setting isDownloaded.
            //            // Download the json file and translate it to dictionnary.
//            guard let jsonDictionnary = weatherWorker.weatherCoreData.translateJsonToDict(nameFileJson: "test") else { print("██░░░ L\(#line) 🚧📕 Error : TranslateJsonToDict failed 🚧🚧 [ \(type(of: self))  \(#function) ]"); return}
            guard let jsonDictionnary = weatherWorker.weatherCoreData.translateJsonToDict(nameFileJson: "city.list.min") else { print("██░░░ L\(#line) 🚧📕 Error : TranslateJsonToDict failed 🚧🚧 [ \(type(of: self))  \(#function) ]"); return}
            weatherWorker.weatherCoreData.createCitiesRows(jsonDictionnary)
        } else {
            print("██░░░ L\(#line) 🚧🚧 Data Already Imported :  🚧🚧 [ \(type(of: self))  \(#function) ]")
        }
    }
}

extension WeatherInteractor : AuthorizationDelegate {
    /** Permission location : get back status permission from WeatherApi. */
    func locationAuthorization(didReceiveAuthorization code: ManagerLocationError) {
        print("  L\(#line)      [🔲🔳🔲\(type(of: self))  🔲🔳🔲\(#function) ] ")
        print("██░░░ L\(#line) 🚧🚧 code autorisation : \(code) 🚧🚧 [ \(type(of: self))  \(#function) ]")
        self.presenter?.presentAskLocationAutorization(code: code)
    }
}
