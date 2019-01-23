//
//  CountryTableViewCellPresenter.swift
//  WorldCountriesApp
//
//  Created by Serhii Palash on 23/01/2019.
//  Copyright © 2019 Serhii Palash. All rights reserved.
//

// MARK: Protocols
protocol CountryTableViewCellPresenter: Presenter {
    init(view: CountryTableViewCell,
         country: Country)
    
    func showCountry()
}

// MARK: Structs
struct CountryTableViewCellPresenterImpl: CountryTableViewCellPresenter {
    
    unowned private var view: CountryTableViewCell
    
    private var country: Country
    
    // MARK: Constructors
    
    init(view: CountryTableViewCell,
         country: Country) {
        self.view = view
        self.country = country
    }
    
    // MARK: General functions
    
    func showCountry() {
        view.showName(country.nativeName ?? "")
    }
}
