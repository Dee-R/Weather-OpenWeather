// ViewController
// WeatherViewController [Display]

// Weather-OpenWeather
// Created by Eddy R on 05/10/2020.
// Copyright © 2020 EddyR. All rights reserved.

import UIKit

// MARK: - ViewController Protocol
protocol WeatherViewControllerProtocol: class {
    func displayChangeColor(_ color: UIColor)
    func displayAskLocationAutorization(_ : String)
    func displayDataCurrentWeather(_ : WeatherModels.GetWeather.ViewModel.DisplayedWeather)
    func displayViewConnectionNotAvailable(_ :Bool)
}
// MARK: - ViewController implementation
class WeatherViewController: UIViewController {
    // ViewController knows :
    var interactor: WeatherInteractorProtocol?
    var router: (NSObjectProtocol & WeatherRouterProtocol & WeatherRouterDataPassing)?  // NSObjectProtocol use to perfom func in an object for handling.
    // MARK: - Animation
    private lazy var spinner: UIActivityIndicatorView = {
        var indicator: UIActivityIndicatorView
        if #available(iOS 13.0, *) {
            indicator = UIActivityIndicatorView.init(style: .large)
        } else {
            // Fallback on earlier versions
            indicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.whiteLarge)
        }
        indicator.color = .gray
        indicator.hidesWhenStopped = true
        return indicator
    }()
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var loadingImage: UIImageView!
    @IBOutlet weak var autorisationPendingView: UIView!
    
    // MARK: - UI OUTLET
    @IBOutlet weak var bgColorWeatherView: UIView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var condition: UIView!
    @IBOutlet weak var viewConnectionNotAvailable: UIView!
    
    // MARK: - UI Constraint
    @IBOutlet weak var cLeadingPictureImageView: NSLayoutConstraint!
    // MARK: - Initialization
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: - View cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //        if spinner.superview == nil, let superView = view.superview {
        if spinner.superview == nil, let superView = loadingView.superview {
            loadingView.addSubview(spinner)
            //            view.addSubview(spinner)
            spinner.translatesAutoresizingMaskIntoConstraints = false
            spinner.centerXAnchor.constraint(equalTo: superView.centerXAnchor).isActive = true
            //            spinner.centerYAnchor.constraint(equalTo: superView.centerYAnchor).isActive = true
            spinner.centerYAnchor.constraint(equalTo: superView.centerYAnchor, constant: 0).isActive = true
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: - Animation with constraint : setup
        
        self.cLeadingPictureImageView.constant -= view.bounds.width + pictureImageView.bounds.width / 2
        self.cLeadingPictureImageView.constant = 0
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        start()
        // MARK: - Animation with constraint : anime
        
//        AnimationFactoryWorker.slideUpToTheRight(mainView: self.view, view: self.pictureImageView, constant: cLeadingPictureImageView).startAnimation()
//        AnimationFactoryWorker.scaleUpandDown(view: pictureImageView)
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // MARK: - IBAction
    @IBAction func refreshLocation(_ sender: Any) {
        print("██░░░ L\(#line) 🚧📕 Refresh 🚧🚧 [ \(type(of: self))  \(#function) ]")
        self.interactor?.getWeatherByCurentLocation()
    }
    
    // MARK: - Method
    func start() {
        configNavigationController() // remove bar navigation
        self.interactor?.actionChangeColor() //test VIP cycle
        self.interactor?.askLocationAutorization() // ask permission Location
        // user hit the box location then  // displayAskLocationAutorization(:String) is called
    }
    
    // MARK: - Builder when the object is unfrozen from IB
    private func setup() {
        let viewController = self
        let interactor = WeatherInteractor()
        let presenter = WeatherPresenter()
        let router = WeatherRouter()
        
        viewController.interactor = interactor
        viewController.router = router
        
        interactor.presenter = presenter
        
        presenter.viewController = viewController
        
        router.dataStore = interactor
        router.viewController = viewController
    }
    
    // MARK: - Routing.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
}

extension WeatherViewController {
    
}

extension WeatherViewController: WeatherViewControllerProtocol {
    func displayChangeColor(_ color: UIColor) {
        self.view.backgroundColor = color
    }
    func displayAskLocationAutorization(_ code : String) {
        print("░░░██❄️❄️ -- 3A  ❄️██░░░ [ \(type(of: self)) L\(#line)")
        switch code {
            case "Pending":
                print("░░░██❄️❄️ -- 3B  ❄️██░░░ [ \(type(of: self)) L\(#line)")
                self.view.backgroundColor = UIColor.orange
                autorisationPendingView.isHidden = false
                //                print("Pending = not determined")
                break
            case "Denied":
                print("░░░██❄️❄️ -- 3C  ❄️██░░░ [ \(type(of: self)) L\(#line)")
                self.view.backgroundColor = UIColor.red
                autorisationPendingView.isHidden = false
                //                print("❄️ Access Denied : show  tutoriel how change location with turoriel ❄️")
                break
            case "Using", "Always":
                print("░░░██❄️❄️ -- 3D  ❄️██░░░ [ \(type(of: self)) L\(#line)")
                
                autorisationPendingView.isHidden = true // cache papier peint violet
                // import data
                self.busyIn()
                DispatchQueue.global(qos: .background).async { [weak self] in
                    self?.interactor?.importDataCity {
                        DispatchQueue.main.async {
                            self?.busyOut()
                        }
                    }
                }
<<<<<<< HEAD
                // STOP HERE 🚦🌁🏝☀️🏖🐬🏝🏞🏜🚦
                break
=======
                
                print("██░░░ L\(#line) 🚧📕 --- A 🚧🚧 [ \(type(of: self))  \(#function) ]")
>>>>>>> bf0426927fd2db11811490158dd0d94a44ce7173
                // present weather from current location
                self.view.backgroundColor = UIColor.gray
                autorisationPendingView.isHidden = true
                
                print("██░░░ L\(#line) 🚧📕 --- B 🚧🚧 [ \(type(of: self))  \(#function) ]")
                self.interactor?.getWeatherByCurentLocation()
                
                break
            default:
                self.view.backgroundColor = UIColor.blue
                break
        }
        
    }
    func configNavigationController() {
        //        self.navigationController!.navigationBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = true
    }
    func displayDataCurrentWeather(_ obj: WeatherModels.GetWeather.ViewModel.DisplayedWeather) {
        print("██░░░ L\(#line) 🚧🚧📐  🚧[ \(type(of: self))  \(#function) ]🚧")
        print(obj)
        
        self.cityLabel.text = "Etrechy"
        self.cityLabel.text = obj.city ?? "null"
        self.timeLabel.text = obj.time
        self.pictureImageView.image = UIImage(named: obj.picture ?? "")
        self.bgColorWeatherView.backgroundColor = obj.color
        self.temperatureLabel.text = " : \(obj.temperature ?? "_") °C"
        self.humidityLabel.text = " : \(obj.humidity ?? "_") % "
        self.windLabel.text = " : \(obj.wind ?? "_") km/h"
        if let conditionLabel = self.condition as? LabelPivoted {
            let conditionText: String = obj.picture ?? "_"
            conditionLabel.label.text =  conditionText.uppercased()
        }
        
    }
    func displayViewConnectionNotAvailable(_ bool :Bool) {
        // add in spinner
        viewConnectionNotAvailable.isHidden = !bool
    }
}
extension WeatherViewController {
    func busyIn() {
                spinner.startAnimating()
//        self.loadingView.isHidden = false
//        self.loadingImage.isHidden = false
    }
    func busyOut() {
                spinner.stopAnimating()
//        self.loadingView.isHidden = true
//        self.loadingImage.isHidden = true
    }
}
