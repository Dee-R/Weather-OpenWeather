// ViewController
// SearchViewController [Display]

// Weather-OpenWeather
// Created by Eddy R on 14/10/2020.
// Copyright © 2020 EddyR. All rights reserved.

import UIKit

// MARK: - ViewController Protocol
protocol SearchViewControllerProtocol: class {
    func displayChangeColor(_ color: UIColor)
}
// MARK: - ViewController implementation
class SearchViewController: UIViewController ,SearchViewControllerProtocol {
    // ViewController knows :
    var interactor: SearchInteractorProtocol?
    var router: (NSObjectProtocol & SearchRouterProtocol & SearchRouterDataPassing)?  // NSObjectProtocol use to perfom func in an object for handling.
    
    // MARK: - UI
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var cancel: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: - View cycle
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        start()
    }
    
    
    // MARK: - Start Action with func or IBAction
    func start() {
        print("██░░░ L\(#line) 🚧🚧📐  🚧[ \(type(of: self))  \(#function) ]🚧")
        setUpIconSearchTextField()
        self.interactor?.actionChangeColor()
    }
    
    // MARK: - Builder when the object is unfrozen from IB
    private func setup() {
        let viewController = self
        let interactor = SearchInteractor()
        let presenter = SearchPresenter()
        let router = SearchRouter()
        
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
        /** should match to the func in the router
         func routeToCreateOrder(segue: UIStoryboardSegue?)
         func routeToShowOrder(segue: UIStoryboardSegue?)
         func routeTo[Name Of The Segue]](segue: UIStoryboardSegue?)
         */
    }
}

extension SearchViewController {
    func displayChangeColor(_ color: UIColor) {
        
        self.view.backgroundColor = color
    }
}

// MARK: - UITEXTFIELD
extension SearchViewController: UITextFieldDelegate {
    func setUpIconSearchTextField() {
        let imageView = UIImageView(frame: CGRect(x: 6, y: 2, width: 15, height: 15))
        let image = UIImage(systemName: "magnifyingglass")
        imageView.image = image
        
        let iconViewContainner: UIView = UIView(frame: CGRect(x:0, y: 0, width: 20, height: 20))
        iconViewContainner.addSubview(imageView)
        
        searchTextField.leftView = iconViewContainner
        searchTextField.leftViewMode = .always
        searchTextField.tintColor = .lightGray
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text,
            let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange,
                                                       with: string)
            print(updatedText)
//            predicateValue = updatedText
//            tableview.reloadData()
//            // 📢 : reload tableView.
        }
        return true
    }
}

// MARK: - TableView
extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}





/*
 ** NSObjectProtocol **   has :
 var hash: Int { get }
 var superclass: AnyClass? { get }
 
 func isEqual(_ object: Any?) -> Bool
 func `self`() -> Self
 func perform(_ aSelector: Selector!) -> Unmanaged<AnyObject>!
 func perform(_ aSelector: Selector!, with object: Any!) -> Unmanaged<AnyObject>!
 func perform(_ aSelector: Selector!, with object1: Any!, with object2: Any!) -> Unmanaged<AnyObject>!
 func isProxy() -> Bool
 func isKind(of aClass: AnyClass) -> Bool
 func isMember(of aClass: AnyClass) -> Bool
 func conforms(to aProtocol: Protocol) -> Bool
 func responds(to aSelector: Selector!) -> Bool
 var description: String { get }
 optional var debugDescription: String { get }
 */
