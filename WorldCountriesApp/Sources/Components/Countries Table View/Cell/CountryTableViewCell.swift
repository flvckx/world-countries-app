//
//  CountryTableViewCell.swift
//  WorldCountriesApp
//
//  Created by Serhii Palash on 23/01/2019.
//  Copyright © 2019 Serhii Palash. All rights reserved.
//

import UIKit

protocol CountryTableViewCell: View {
    func showName(_ name: String)
}

final class CountryTableViewCellImpl: UITableViewCell, CountryTableViewCell {
    
    // MARK: Constants
    static let height: CGFloat = 70
    
    // MARK: IBOutlet
    @IBOutlet private weak var countryNameLabel: UILabel!
    
    // MARK: Properties
    var presenter: CountryTableViewCellPresenter!
    
    // MARK: General functions
    func willDisplay() {
        presenter.showCountry()
    }
    
    func showName(_ name: String) {
        countryNameLabel.text = name
    }
}


