//
//  CountriesTablePresenter.swift
//  WorldCountriesApp
//
//  Created by Serhii Palash on 22/01/2019.
//  Copyright © 2019 Serhii Palash. All rights reserved.
//

import UIKit

protocol CountriesTablePresenterDelegate: Delegate {
    func countriesTablePresenterDidSelectCountry(country: Country, presenter: CountriesTablePresenter)
}

protocol CountriesTablePresenter: Presenter {
    var countriesCount: Int { get }
    
    func countryFor(index: Int) -> Country
    func didSelectCountryAt(index: Int)
}

class CountriesTablePresenterImpl: CountriesTablePresenter {
    
    weak var delegate: CountriesTablePresenterDelegate?
    
    unowned private let tableView: CountriesTableView
    
    var countries: [Country] = [] {
        didSet {
            self.tableView.showCountries()
        }
    }
    
    var countriesCount: Int {
        return countries.count
    }
    
    required init(view: CountriesTableView) {
        self.tableView = view
    }
    
    func didSelectCountryAt(index: Int) {
        delegate?.countriesTablePresenterDidSelectCountry(country: countries[index], presenter: self)
        tableView.showCountryAt(index: index)
    }
    
    func countryFor(index: Int) -> Country {
        return countries[index]
    }
}

