//
//  AppFlow.swift
//  WorldCountriesApp
//
//  Created by Serhii Palash on 22/01/2019.
//  Copyright © 2019 Serhii Palash. All rights reserved.
//

import UIKit

class AppFlow {
    
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        showCountriesScene()
    }
    
    private func showCountriesScene() {
        let countriesNavigationController = AppRouter.CountriesScene().mainNavigationController
        guard let countriesListViewController = countriesNavigationController?.viewControllers.first as? CountriesListViewControllerImpl else {
            return
        }
        
        let countriesListPresenter = CountriesListPresenterImpl(view: countriesListViewController)
        countriesListViewController.presenter = countriesListPresenter
        
        window.rootViewController = countriesNavigationController
        window.makeKeyAndVisible()
    }
}
