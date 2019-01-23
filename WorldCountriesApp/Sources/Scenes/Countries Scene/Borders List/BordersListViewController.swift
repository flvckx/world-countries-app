//
//  BordersListViewController.swift
//  WorldCountriesApp
//
//  Created by Serhii Palash on 23/01/2019.
//  Copyright © 2019 Serhii Palash. All rights reserved.
//

import UIKit

protocol BordersListView: View {
    
}

class BordersListViewController: UIViewController, BordersListView {
    
    // MARK: IBOutlets
    @IBOutlet private weak var countriesTableView: CountriesTableViewImpl!
    
    // MARK: Properties
    var presenter: BordersListPresenterImpl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Borders"
        
        let countriesTablePresenter = CountriesTablePresenterImpl(view: countriesTableView)
        countriesTableView.presenter = countriesTablePresenter
        presenter.countriesTablePresenter = countriesTablePresenter
        
        presenter.didLoad()
    }
}
