//
//  Country+CoreDataClass.swift
//  WorldCountriesApp
//
//  Created by Serhii Palash on 22/01/2019.
//  Copyright © 2019 Serhii Palash. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Country)
public class Country: NSManagedObject, Decodable {

    @NSManaged public var nativeName: String?
    @NSManaged public var borders: Set<String>?
    
    enum CodingKeys: String, CodingKey {
        case nativeName
        case borders
    }
    
    public required convenience init(from decoder: Decoder) throws {
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
            let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
            let entity = NSEntityDescription.entity(forEntityName: "Country", in: managedObjectContext) else {
                fatalError("Failed to decode Country")
        }
        
        self.init(entity: entity, insertInto: managedObjectContext)
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.nativeName = try container.decodeIfPresent(String.self, forKey: .nativeName)
        self.borders = try container.decodeIfPresent(Set<String>.self, forKey: .borders)
    }
}

public extension CodingUserInfoKey {
    static let managedObjectContext = CodingUserInfoKey(rawValue: "managedObjectContext")
}
