//
//  FoodTrackerTests.swift
//  FoodTrackerTests
//
//  Created by ASM on 2/19/18.
//

import XCTest
@testable import FoodTracker

@objcMembers class FoodTrackerTests: XCTestCase {
    
    //MARK: Meal Class Tests
    //Confirm that the Meal initializer returns a Meal object when passed valid parameters.
    func testMealInitializationSucceeds() {
        //Zero rating
        let zeroRatingMeal = Meal(name: "Zero", photo: nil, rating: 0, recipe: nil)
        XCTAssertNotNil(zeroRatingMeal)
        
        //Highest positive rating
        let positiveRatingMeal = Meal(name: "Positive", photo: nil, rating: 5, recipe: nil)
        XCTAssertNotNil(positiveRatingMeal)
    }
    
    //Confirm that the meal intializer return nil when passed a negative rating or an empty name.
    func testMealInitializationFails() {
        //Negative rating
        let negativeRatingMeal = Meal.init(name: "Negative", photo: nil, rating: -1, recipe: nil)
        XCTAssertNil(negativeRatingMeal)
        
        //Rating exceeds maximum
        let largestRatingMeal = Meal.init(name: "Large", photo: nil, rating: 6, recipe: nil)
        XCTAssertNil(largestRatingMeal)
        
        //Empty string
        let emptyStringMeal = Meal.init(name: "", photo: nil, rating: 0, recipe: nil)
        XCTAssertNil(emptyStringMeal)
    }

    
}
