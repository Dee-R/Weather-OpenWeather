//
//  ConvertorWorker.swift
//  Weather-OpenWeather
//
//  Created by Eddy R on 13/10/2020.
//  Copyright © 2020 EddyR. All rights reserved.
//
import Foundation
import UIKit

class ConvertorWorker {
    enum ColorCondition: RawRepresentable {
        //01
        typealias RawValue = UIColor
        //02
        case sunny,sunnyn, snowy,cloudydlight ,cloudyd, cloudyn, rainy,rainyn, thunderstormy,thunderstormyn, storm, misty, none
        //04
        init?(rawValue: UIColor) {
            switch rawValue {
                default:
                    return nil
            }
        }
        // 03
        var rawValue: UIColor {
            switch self {
                case .sunny:
                    return UIColor.rgb(red: 129, green: 207, blue: 213)
                case .sunnyn:
                    return UIColor.rgb(red: 69, green: 79, blue: 134)
                case .snowy:
                    return UIColor.rgb(red: 132, green: 0, blue: 181)
                case .cloudydlight:
                    return UIColor.rgb(red: 125, green: 188, blue: 227)
                case .cloudyn:
                    return UIColor.rgb(red: 69, green: 79, blue: 134)
                case .cloudyd:
                    return UIColor.rgb(red: 109, green: 161, blue: 209)
                case .rainy:
                    return UIColor.rgb(red: 16, green: 124, blue: 255)
                case .rainyn:
                    return UIColor.rgb(red: 40, green: 44, blue: 107)
                case .thunderstormy:
                    return UIColor.rgb(red: 252, green: 66, blue: 100)
                case .thunderstormyn:
                    return UIColor.rgb(red: 50, green: 56, blue: 91)
                case .misty:
                    return UIColor.rgb(red: 0, green: 45, blue: 51)
                case .storm:
                    return UIColor.rgb(red: 197, green: 94, blue: 155)
                case .none:
                    return UIColor.rgb(red: 1, green: 147, blue: 168)
            }
        }
    }
    
    static func codeDataWther(idWeather: Int ,idIcon:String) -> (String, UIColor) {
        switch idWeather {
            case let x where (x >= 200 && x <= 202) || (x >= 230 && x <= 232):
                if (idIcon == "11d") {
                    return ("thunderstormy",ConvertorWorker.ColorCondition.thunderstormy.rawValue)
                } else {
                    return ("thunderstormyn",ConvertorWorker.ColorCondition.thunderstormyn.rawValue)
            }
            //                return "⛈"
            case let x where x >= 210 && x <= 211:
                if (idIcon == "11d") {
                    return ("thunderstormy",ConvertorWorker.ColorCondition.thunderstormy.rawValue)
                } else {
                    return ("thunderstormyn",ConvertorWorker.ColorCondition.thunderstormyn.rawValue)
            }
            //                return "🌩"
            case let x where x >= 212 && x <= 221:
                if (idIcon == "11d") {
                    return ("thunderstormy",ConvertorWorker.ColorCondition.thunderstormy.rawValue)
                } else {
                    return ("thunderstormyn",ConvertorWorker.ColorCondition.thunderstormyn.rawValue)
                }
                
            //                return "⚡️"
            case let x where x >= 300 && x <= 321:
                return ("misty",ConvertorWorker.ColorCondition.misty.rawValue)
            //                return "🌦"
            case let x where x >= 500 && x <= 531:
                if (idIcon == "09d" || idIcon == "13d" || idIcon == "10d") {
                    return ("rainyd",ConvertorWorker.ColorCondition.rainy.rawValue)
                } else {
                    return ("rainyn",ConvertorWorker.ColorCondition.rainyn.rawValue)
                }
            //                return "🌧"
            case let x where x >= 600 && x <= 602:
                return ("snow",ConvertorWorker.ColorCondition.snowy.rawValue)
            //                return "☃️"
            case let x where x >= 603 && x <= 622:
                return ("snow",ConvertorWorker.ColorCondition.snowy.rawValue)
            //                return "🌨"
            case let x where x >= 701 && x <= 771:
                // name of picture
                return ("misty",ConvertorWorker.ColorCondition.misty.rawValue)
            //                return "🌫"
            case let x where x == 781 || x == 900:
                return ("storm",ConvertorWorker.ColorCondition.storm.rawValue)
            //                return "🌪"
            case let x where x == 800:
                if idIcon == "01d" {
                    print("DayTime")
                    return ("sunnyd",ConvertorWorker.ColorCondition.sunny.rawValue)
                } else {
                    print("nightTime")
                    return ("sunnyn",ConvertorWorker.ColorCondition.sunnyn.rawValue)
                }
                
            //                return isDayTime ? "☀️" : "🌕"
            case let x where x == 801:
                if idIcon == "02d" {
                    //day taime
                    return ("cloudyd801",ConvertorWorker.ColorCondition.cloudyd.rawValue)
                } else {
                    //nightTime
                    return ("cloudyn801",ConvertorWorker.ColorCondition.cloudyn.rawValue)
            }
            //                return "🌤"
            case let x where x == 802:
                if idIcon == "03d" {
                    //day taime
                    return ("cloudyd802",ConvertorWorker.ColorCondition.cloudyd.rawValue)
                } else {
                    //nightTime
                    return ("cloudyn802",ConvertorWorker.ColorCondition.cloudyn.rawValue)
            }
            //                return "⛅️"
            case let x where x == 803:
                if idIcon == "04d" {
                    //day taime
                    return ("cloudyd803",ConvertorWorker.ColorCondition.cloudyd.rawValue)
                } else {
                    //nightTime
                    return ("cloudyn803",ConvertorWorker.ColorCondition.cloudyn.rawValue)
                }
            //                return "🌥"
            case let x where x == 804:
                if idIcon == "04d" {
                    //day taime
                   return ("cloudyd804",ConvertorWorker.ColorCondition.cloudyd.rawValue)
                } else {
                    //nightTime
                    return ("cloudyn804",ConvertorWorker.ColorCondition.cloudyn.rawValue)
                }
            
            //                return "☁️"
            case let x where x >= 952 && x <= 956 || x == 905:
                return ("sunny",ConvertorWorker.ColorCondition.sunny.rawValue)
            //                return "🌬"
            case let x where x >= 957 && x <= 961 || x == 771:
                return ("sunny",ConvertorWorker.ColorCondition.sunny.rawValue)
            //                return "💨"
            case let x where x == 901 || x == 902 || x == 962:
                return ("sunny",ConvertorWorker.ColorCondition.sunny.rawValue)
            //                return "🌀"
            case let x where x == 903:
                return ("sunny",ConvertorWorker.ColorCondition.sunny.rawValue)
            //                return "❄️"
            case let x where x == 904:
                return ("snowy",ConvertorWorker.ColorCondition.snowy.rawValue)
            //                return "🌡"
            case let x where x == 962:
                return ("sunny",ConvertorWorker.ColorCondition.sunny.rawValue)
            //                return "🌋"
            default:
                return ("",ConvertorWorker.ColorCondition.none.rawValue)
            //                return "❓"
        }
    }
    /*
    static func weatherCodeToPicture(conditionCode: Int?) -> (String, UIColor) {
        guard let code = conditionCode else {
            return ("", ConvertorWorker.ColorCondition.none.rawValue)
        }
        switch code {
            case let x where (x >= 200 && x <= 202) || (x >= 230 && x <= 232):
                return ("thunderstormy",ConvertorWorker.ColorCondition.thunderstormy.rawValue)
            //                return "⛈"
            case let x where x >= 210 && x <= 211:
                return ("thunderstormy",ConvertorWorker.ColorCondition.thunderstormy.rawValue)
            //                return "🌩"
            case let x where x >= 212 && x <= 221:
                return ("thunderstormy",ConvertorWorker.ColorCondition.thunderstormy.rawValue)
            //                return "⚡️"
            case let x where x >= 300 && x <= 321:
                return ("misty",ConvertorWorker.ColorCondition.misty.rawValue)
            //                return "🌦"
            case let x where x >= 500 && x <= 531:
                return ("rainy",ConvertorWorker.ColorCondition.rainy.rawValue)
            //                return "🌧"
            case let x where x >= 600 && x <= 602:
                return ("sunny",ConvertorWorker.ColorCondition.sunny.rawValue)
            //                return "☃️"
            case let x where x >= 603 && x <= 622:
                return ("sunny",ConvertorWorker.ColorCondition.sunny.rawValue)
            //                return "🌨"
            case let x where x >= 701 && x <= 771:
                return ("sunny",ConvertorWorker.ColorCondition.sunny.rawValue)
            //                return "🌫"
            case let x where x == 781 || x == 900:
                return ("sunny",ConvertorWorker.ColorCondition.sunny.rawValue)
            //                return "🌪"
            case let x where x == 800:
                return ("sunny",ConvertorWorker.ColorCondition.sunny.rawValue)
            //                return isDayTime ? "☀️" : "🌕"
            case let x where x == 801:
                return ("cloudy",ConvertorWorker.ColorCondition.cloudy.rawValue)
            //                return "🌤"
            case let x where x == 802:
                return ("cloudy",ConvertorWorker.ColorCondition.cloudy.rawValue)
            //                return "⛅️"
            case let x where x == 803:
                return ("cloudy",ConvertorWorker.ColorCondition.cloudy.rawValue)
            //                return "🌥"
            case let x where x == 804:
                return ("cloudy",ConvertorWorker.ColorCondition.cloudy.rawValue)
            //                return "☁️"
            case let x where x >= 952 && x <= 956 || x == 905:
                return ("sunny",ConvertorWorker.ColorCondition.sunny.rawValue)
            //                return "🌬"
            case let x where x >= 957 && x <= 961 || x == 771:
                return ("sunny",ConvertorWorker.ColorCondition.sunny.rawValue)
            //                return "💨"
            case let x where x == 901 || x == 902 || x == 962:
                return ("sunny",ConvertorWorker.ColorCondition.sunny.rawValue)
            //                return "🌀"
            case let x where x == 903:
                return ("sunny",ConvertorWorker.ColorCondition.sunny.rawValue)
            //                return "❄️"
            case let x where x == 904:
                return ("snowy",ConvertorWorker.ColorCondition.snowy.rawValue)
            //                return "🌡"
            case let x where x == 962:
                return ("sunny",ConvertorWorker.ColorCondition.sunny.rawValue)
            //                return "🌋"
            default:
                return ("",ConvertorWorker.ColorCondition.none.rawValue)
            //                return "❓"
        }
        
    }
    */
    /// convert kelvin to celsuis
    /// - Parameter temp: temperature
    /// - Returns: temperatur in celsuis
    static func tempToCelsuis(_ temp: Float) -> Float{
        return roundf(temp - 273.15)
    }
    static func windBykmPerHour(valuePerMeterSecond: Float) -> Float {
        let x = valuePerMeterSecond * 3.6
        return (x*10).rounded()/10
    }
}

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}
extension Float {
    var clean: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}
