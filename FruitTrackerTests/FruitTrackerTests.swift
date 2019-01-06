//
//  FruitTrackerTests.swift
//  FruitTrackerTests
//
//  Created by gkw on 2018/12/13.
//  Copyright © 2018 BodyFusion Inc. All rights reserved.
//

@testable import FruitTracker
import XCTest

class FruitTrackerTests: XCTestCase {
  // MARK: Fruit Class Tests
  
  // Confirm that the Fruit initializer returns a Fruit object when passed valid parameters
  func testFruitInitializationSucceeds() {
    // Zero rating
    let zeroRatingFruit = Fruit(name: "Zero", photo: nil, rating: 0)
    XCTAssertNotNil(zeroRatingFruit)
    
    // Highest positive rating
    let positiveRatingFruit = Fruit(name: "Positive", photo: nil, rating: 5)
    XCTAssertNotNil(positiveRatingFruit)
  }
  
  // Confirm that the Fruit initializer returns nil when passed a negative rating or an empty name
  func testFruitInitializationFails() {
    // Negative rating
    let negativeRatingFruit = Fruit(name: "Negative", photo: nil, rating: -1)
    XCTAssertNil(negativeRatingFruit)
    
    // Rating exceeds maximum
    let largeRatingFruit = Fruit(name: "Large", photo: nil, rating: 6)
    XCTAssertNil(largeRatingFruit)
    
    // Empty String
    let emptyStringFruit = Fruit(name: "", photo: nil, rating: 0)
    XCTAssertNil(emptyStringFruit)
  }
}
