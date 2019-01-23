//
//  DatabaseService.swift
//  WorldCountriesApp
//
//  Created by Serhii Palash on 23/01/2019.
//  Copyright © 2019 Serhii Palash. All rights reserved.
//


import CoreData
import UIKit

protocol DatabaseService: Service {
    func fetchCountries() -> [Country]?
}

class DatabaseServiceImpl: DatabaseService {
    
    private lazy var context: NSManagedObjectContext = {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("Couldn't initializa UIApplication delegate as AppDelegate.")
        }
        
        let context = appDelegate.persistentContainer.viewContext
        return context
    }()
    
    func fetchCountries() -> [Country]? {
        let fetchRequest = NSFetchRequest<Country>(entityName: Country.description())
        return try? context.fetch(fetchRequest)
    }
}
