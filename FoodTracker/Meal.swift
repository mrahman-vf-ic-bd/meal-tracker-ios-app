//
//  Meal.swift
//  FoodTracker
//
//  Created by Siddiqur Rahmnan on 25/5/20.
//  Copyright © 2020 Siddiqur Rahmnan. All rights reserved.
//

import UIKit
import os.log

class Meal: NSObject, NSCoding {
    //MARK: Properties
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = Meal.DocumentsDirectory.appendingPathComponent("meals")
    
    struct PropertyKey {
        static let name = "name"
        static let photo = "photo"
        static let rating = "rating"
    }

    var name: String
    var photo: UIImage?
    var rating: Int
    
    //MARK: Initialization
    init?(name: String, photo: UIImage?, rating: Int) {
        guard !name.isEmpty else {
            return nil
        }
        guard rating >= 0 && rating <= 5 else {
            return nil
        }
        self.name = name
        self.photo = photo
        self.rating = rating
    }
    
    //MARK: NSCoding
    func encode(with encoder: NSCoder) {
        encoder.encode(name, forKey: PropertyKey.name)
        encoder.encode(photo, forKey: PropertyKey.photo)
        encoder.encode(rating, forKey: PropertyKey.rating)
    }
    
    required convenience init?(coder decoder: NSCoder) {
        guard let name = decoder.decodeObject(forKey: PropertyKey.name) as? String else {
            os_log("Unable to decode the name for a Meal objject.", log: OSLog.default, type: .debug)
            return nil
        }
        let photo = decoder.decodeObject(forKey: PropertyKey.photo) as? UIImage
        let rating = decoder.decodeInteger(forKey: PropertyKey.rating)
        
        self.init(name: name, photo: photo, rating: rating)
    }
}
