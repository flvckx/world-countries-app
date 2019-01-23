//
//  CountriesSceneRouter.swift
//  WorldCountriesApp
//
//  Created by Serhii Palash on 23/01/2019.
//  Copyright © 2019 Serhii Palash. All rights reserved.
//

import UIKit

protocol CountriesSceneRouter {
    init(viewController: UIViewController)
    
    func navigateToCountryBorders(_ country: Country)
}

final class CountriesSceneRouterImpl: CountriesSceneRouter {
    
    unowned var viewController: UIViewController
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    private func show(_ viewController: UIViewController) {
        self.viewController.navigationController?.show(viewController, sender: nil)
    }
    
    func navigateToCountryBorders(_ country: Country) {

    }
}
