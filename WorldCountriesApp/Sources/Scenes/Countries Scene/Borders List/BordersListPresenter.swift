//
//  BordersListPresenter.swift
//  WorldCountriesApp
//
//  Created by Serhii Palash on 23/01/2019.
//  Copyright © 2019 Serhii Palash. All rights reserved.
//

protocol BordersListPresenter: Presenter {
    var countriesTablePresenter: CountriesTablePresenterImpl! { get set }

    init(view: BordersListView,
         country: Country,
         databaseService: DatabaseService)
    
    func didLoad()
}

class BordersListPresenterImpl: BordersListPresenter {
    
    private weak var view: BordersListView?
    
    private let country: Country
    private let databaseService: DatabaseService
    
    var countriesTablePresenter: CountriesTablePresenterImpl!
    
    required init(view: BordersListView,
                  country: Country,
                  databaseService: DatabaseService) {
        self.view = view
        self.country = country
        self.databaseService = databaseService
    }
    
    func didLoad() {
        guard let countries = databaseService.fetchCountries(country.borders ?? []) else {
            return
        }
        
        countriesTablePresenter.countries = countries
    }
}

