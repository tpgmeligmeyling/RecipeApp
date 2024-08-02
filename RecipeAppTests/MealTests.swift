//
//  MealTests.swift
//  RecipeAppTests
//
//  Created by Thomas Gmelig Meyling on 01/08/2024.
//

import XCTest
@testable import RecipeApp

final class MealTests: XCTestCase {

    override func setUpWithError() throws {}
    override func tearDownWithError() throws {}

    func testMealInit() {
        
        let id = 53049
        let name = "Apam balik"
        let url = URL(string: "https://www.themealdb.com//images//media//meals//adxcbq1619787919.jpg")!
        
        let sut = Meal(
            id: id,
            name: name,
            thumbnailURL: url
        )
        
        XCTAssertEqual(id, sut.id)
        XCTAssertEqual(name, sut.name)
        XCTAssertEqual(url, sut.thumbnailURL)
    }
    
    func testMealDecoding() {
        let json = """
            {"strMeal":"Apam balik","strMealThumb":"https://www.themealdb.com//images//media//meals//adxcbq1619787919.jpg","idMeal":"53049"}
            """

        
        let id = 53049
        let name = "Apam balik"
        let url = URL(string: "https://www.themealdb.com//images//media//meals//adxcbq1619787919.jpg")!
        
        let meal = Meal(
            id: id,
            name: name,
            thumbnailURL: url
        )
        
        let sut = try? JSONDecoder().decode(Meal.self, from: json.data(using: .utf8)!)
        
        XCTAssertEqual(meal.id, sut?.id)
        XCTAssertEqual(meal.name, sut?.name)
        XCTAssertEqual(meal.thumbnailURL, sut?.thumbnailURL)
    }

}
