//
//  CountriesLoadingService.swift
//  WorldCountriesApp
//
//  Created by Serhii Palash on 23/01/2019.
//  Copyright © 2019 Serhii Palash. All rights reserved.
//

import Foundation
import UIKit

fileprivate let urlPath: String = "https://restcountries.eu/rest/v2/all"

protocol CountriesLoadingService: Service {
    func loadCountries(completion: @escaping ([Country]?) -> Void)
}

class CountriesLoadingServiceImpl: CountriesLoadingService {
    
    func loadCountries(completion: @escaping ([Country]?) -> Void) {
        guard let url = URL(string: urlPath) else {
            return
        }
        
        let session = URLSession.shared
        let task = session.dataTask(with: url) { [weak self] (data, response, error) in
            guard let data = data else {
                return
            }
                
            DispatchQueue.main.async {
                guard let countries = try? self?.decode(data) else {
                    return
                }
                
                completion(countries)
            }
        }
        
        task.resume()
    }
}

// MARK: Private methods
private extension CountriesLoadingServiceImpl {
    
    func decode(_ data: Data) throws -> [Country]? {
        let decoder = JSONDecoder()
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return nil
        }
        
        let context = appDelegate.persistentContainer.viewContext
        decoder.userInfo[CodingUserInfoKey.managedObjectContext!] = context
        
        do {
            let countries = try decoder.decode([Country].self, from: data)
            try context.save()
            
            return countries
        } catch let error {
            throw error
        }
    }
}
