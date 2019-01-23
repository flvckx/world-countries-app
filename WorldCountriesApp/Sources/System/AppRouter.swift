//
//  AppRouter.swift
//  WorldCountriesApp
//
//  Created by Serhii Palash on 22/01/2019.
//  Copyright © 2019 Serhii Palash. All rights reserved.
//

import UIKit

struct AppRouter {
    
    struct CountriesScene {
        
        private static let storyboard = UIStoryboard(name: "CountriesScene", bundle: nil)
        
        private enum Screens: String {
            case countries = "CountriesNavigationController"
            case countryBorders = "CountryBordersViewImpl"
        }
        
        let mainNavigationController = storyboard.instantiateViewController(
            withIdentifier: Screens.countries.rawValue) as? UINavigationController
        
//        let countryBordersViewController = storyboard.instantiateViewController(
//            withIdentifier: Screens.countryBorders.rawValue) as? CountryBordersViewImpl
    }
}
