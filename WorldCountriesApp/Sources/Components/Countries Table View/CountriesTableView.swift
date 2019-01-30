//
//  CountriesTableView.swift
//  WorldCountriesApp
//
//  Created by Serhii Palash on 22/01/2019.
//  Copyright © 2019 Serhii Palash. All rights reserved.
//

import UIKit

protocol CountriesTableView: View {
    func showCountryAt(index: Int)
    func showCountries()
}

class CountriesTableViewImpl: UITableView {
    
    var presenter: CountriesTablePresenter!
    
    override init(frame: CGRect, style: Style) {
        super.init(frame: frame, style: style)
        
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        configure()
    }
    
    private func configure() {
        let identifier = String(describing: CountryTableViewCell.self)
        let nib = UINib(nibName: identifier, bundle:nil)
        self.register(nib, forCellReuseIdentifier: identifier)
        self.rowHeight = CountryTableViewCellImpl.height
        self.tableFooterView = UIView(frame: .zero)
        self.delegate = self
        self.dataSource = self
        
    }
    
}

extension CountriesTableViewImpl: CountriesTableView {
    
    func showCountries() {
        self.reloadData()
    }
    
    func showCountryAt(index: Int) {
        let indexPath = IndexPath(row: index, section: 0)
        self.reloadRows(at: [indexPath], with: .none)
    }
}

extension CountriesTableViewImpl: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.countriesCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = String(describing: CountryTableViewCell.self)
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? CountryTableViewCellImpl else {
            fatalError("Unable to dequeue reusable cell with CountryTableViewCellImpl identifier.")
        }
        
        let country = presenter.countryFor(index: indexPath.row)
        let cellPresenter = CountryTableViewCellPresenterImpl(view: cell, country: country)
        
        cell.presenter = cellPresenter
        cell.willDisplay()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectCountryAt(index: indexPath.row)
    }
}


