//
//  CountriesListPresenter.swift
//  WorldCountriesApp
//
//  Created by Serhii Palash on 23/01/2019.
//  Copyright © 2019 Serhii Palash. All rights reserved.
//

import Foundation

protocol CountriesListPresenter: Presenter {
    var countriesTablePresenter: CountriesTablePresenterImpl! { get set }
    
    init(view: CountriesListView,
         databaseService: DatabaseService,
         countriesLoadingService: CountriesLoadingService)
    
    func didLoad()
}

class CountriesListPresenterImpl: CountriesListPresenter {
    
    private weak var view: CountriesListView?
    
    private var newsLoadingService: CountriesLoadingService
    private var databaseService: DatabaseService
    
    private var isLazyLoadingInProgress = false
    
    var countriesTablePresenter: CountriesTablePresenterImpl! {
        didSet {
            countriesTablePresenter.delegate = self
        }
    }
    
    // MARK: Constructors
    required init(view: CountriesListView,
                  databaseService: DatabaseService,
                  countriesLoadingService: CountriesLoadingService) {
        self.view = view
        self.databaseService = databaseService
        self.newsLoadingService = newsLoadingService
    }
    
    func didLoad() {
        view?.showLoadingPageView()
        // load countries and save
    }
}

// MARK: NewsTablePresenterDelegate
extension CountriesListPresenterImpl: CountriesTablePresenterDelegate {

    func countriesTablePresenterDidSelectCountry(country: Country, presenter: CountriesTablePresenter) {
        view?.openCountryBorders(country: country)
    }
}

// MARK: Private fucntions
private extension CountriesListPresenterImpl {
    
}

