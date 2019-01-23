//
//  ViewController.swift
//  WorldCountriesApp
//
//  Created by Serhii Palash on 22/01/2019.
//  Copyright © 2019 Serhii Palash. All rights reserved.
//

import UIKit

protocol CountriesListView: View {
    func showCountriesTableView()
    func hideCountriesTableView()
    func openCountryBorders(country: Country)
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
    
    func showCountriesTableView() {
        countriesTableView.isHidden = false
    }
    
    func hideCountriesTableView() {
        countriesTableView.isHidden = true
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
