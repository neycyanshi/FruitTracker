//
//  Fruit.swift
//  FruitTracker
//
//  Created by gkw on 2018/12/28.
//  Copyright © 2018 BodyFusion Inc. All rights reserved.
//

import UIKit

class Fruit {
  // MARK: Properties

  var name: String
  var photo: UIImage?
  var rating: Int

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
}
