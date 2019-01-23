//
//  ViewController.swift
//  WorldCountriesApp
//
//  Created by Serhii Palash on 22/01/2019.
//  Copyright © 2019 Serhii Palash. All rights reserved.
//

import UIKit

protocol CountriesListView: View {
    func showNewsTableView()
    func hideNewsTableView()
    func openCountryBorders(country: Country)
    func showLoadingPageView()
    func hideLoadingPageView()
}

final class CountriesListViewControllerImpl: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet private weak var countriesTableView: CountriesTableViewImpl!
    
    // MARK: Properties
    var presenter: CountriesListPresenterImpl!
    var router: CountriesSceneRouter!
    
    var loadingPageView: LoadingPageView?
    
    // MARK: Virtual functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        router = CountriesSceneRouterImpl(viewController: self)
        
        let newsTablePresenter = NewsTablePresenterImpl(view: feedTableView)
        feedTableView.presenter = newsTablePresenter
        presenter.newsTablePresenter = newsTablePresenter
        
        loadingPageView = LoadingPageView(frame: self.view.frame)
        loadingPageView?.loadingText = "Synching.."
        
        presenter.didLoad()
    }
}

extension NewsFeedViewControllerImpl: CountriesListView {
    
    func openNewsDetails(news: News) {
        router.navigateToNewsDetails(news)
    }
    
    func showNewsTableView() {
        feedTableView.isHidden = false
    }
    
    func hideNewsTableView() {
        feedTableView.isHidden = true
    }
    
    func showLoadingPageView() {
        UIApplication.shared.keyWindow?.addSubview(loadingPageView!)
        loadingPageView?.show(completion: nil)
    }
    
    func hideLoadingPageView() {
        loadingPageView?.hide(completion: {
            self.loadingPageView?.removeFromSuperview()
        })
    }
}
