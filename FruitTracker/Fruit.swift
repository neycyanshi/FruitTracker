//
//  Fruit.swift
//  FruitTracker
//
//  Created by yanshi on 2018/12/28.
//  Copyright © 2018 BodyFusion Inc. All rights reserved.
//

import os.log
import UIKit

class Fruit: NSObject, NSCoding {
  // MARK: Properties
  
  var name: String
  var photo: UIImage?
  var rating: Int
  
  // MARK: Archiving Paths
  
  static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
  static let ArchiveURL = DocumentsDirectory.appendingPathComponent("fruits")
  
  // MARK: Types
  
  struct PropertyKey {
    // static indicates that these constants belong to the structure itself, not to instances of the structure.
    // use constant instead of retyping the string (which increases the likelihood of mistakes).
    static let name = "name"
    static let photo = "photo"
    static let rating = "rating"
  }
  
  // MARK: Initialization
  
  init?(name: String, photo: UIImage?, rating: Int) {
    // The name must not be empty
    guard !name.isEmpty else {
      return nil
    }
    
    // The rating must be between 0 and 5 inclusively
    guard rating >= 0, (rating <= 5) else {
      return nil
    }
    
    // Initialize sorted properties
    self.name = name
    self.photo = photo
    self.rating = rating
  }
  
  // MARK: NSCoding
  
  // Two methods NSCoding must implement to save and load data.
  func encode(with aCoder: NSCoder) {
    aCoder.encode(name, forKey: PropertyKey.name)
    aCoder.encode(photo, forKey: PropertyKey.photo)
    aCoder.encode(rating, forKey: PropertyKey.rating)
  }
  
  required convenience init?(coder aDecoder: NSCoder) {
    // The name is required. If we cannot decode a name string, the initializer should fail.
    guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
      os_log("Unable to decode the name for a Fruit object.", log: OSLog.default, type: .debug)
      return nil
    }
    // Because photo is an optional property of Fruit, just use conditional cast.
    let photo = aDecoder.decodeObject(forKey: PropertyKey.photo) as? UIImage
    let rating = aDecoder.decodeInteger(forKey: PropertyKey.rating)
    
    // Must call designated initializer
    self.init(name: name, photo: photo, rating: rating)
  }
}
