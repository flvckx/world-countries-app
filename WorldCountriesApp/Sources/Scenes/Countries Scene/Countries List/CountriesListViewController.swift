//
//  ViewController.swift
//  WorldCountriesApp
//
//  Created by Serhii Palash on 22/01/2019.
//  Copyright © 2019 Serhii Palash. All rights reserved.
//

import UIKit

protocol CountriesListView: View {
    func openCountryBorders(country: Country)
    func showAlert(_ message: String)
    func showLoadingPageView()
    func hideLoadingPageView()
}

final class CountriesListViewControllerImpl: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet private weak var countriesTableView: CountriesTableViewImpl!
    
    // MARK: Properties
    var presenter: CountriesListPresenterImpl!
    var router: CountriesSceneRouter!
    
    var loadingPageView: LoadingPageView?
    
    // MARK: Virtual functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        router = CountriesSceneRouterImpl(viewController: self)
        
        let countriesTablePresenter = CountriesTablePresenterImpl(view: countriesTableView)
        countriesTableView.presenter = countriesTablePresenter
        presenter.countriesTablePresenter = countriesTablePresenter
        
        loadingPageView = LoadingPageView(frame: self.view.frame)
        loadingPageView?.loadingText = "Please, wait.. Initial loading is proceeding."
        
        presenter.didLoad()
    }
}

extension CountriesListViewControllerImpl: CountriesListView {
    
    func openCountryBorders(country: Country) {
        router.navigateToCountryBorders(country)
    }
    
    func showAlert(_ message: String) {
        let alertController = UIAlertController(title: "WorldCountriesApp",
                                                message: message,
                                                preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK",
                                     style: .default)
        alertController.addAction(okAction)
        
        present(alertController, animated: true)
    }
    
    func showLoadingPageView() {
        UIApplication.shared.keyWindow?.addSubview(loadingPageView!)
        loadingPageView?.show(completion: nil)
    }
    
    func hideLoadingPageView() {
        loadingPageView?.hide(completion: {
            self.loadingPageView?.removeFromSuperview()
        })
    }
}
