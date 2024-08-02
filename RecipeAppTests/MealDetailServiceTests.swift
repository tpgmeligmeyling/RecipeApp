//
//  MealDetailServiceTests.swift
//  RecipeAppTests
//
//  Created by Thomas Gmelig Meyling on 01/08/2024.
//

import XCTest
@testable import RecipeApp

final class MealDetailServiceTests: XCTestCase {
    
    lazy var session: URLSession = {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        return URLSession(configuration: configuration)
    }()
    
    lazy var service = MealDetailService(session: session)
    
    let expected: MealDetail = {
        let id = 53049
        let name = "Apam balik"
        let url = URL(string: "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg")!
        let instructions = "Mix milk, oil and egg together. Sift flour, baking powder and salt into the mixture. Stir well until all ingredients are combined evenly.\r\n\r\nSpread some batter onto the pan. Spread a thin layer of batter to the side of the pan. Cover the pan for 30-60 seconds until small air bubbles appear.\r\n\r\nAdd butter, cream corn, crushed peanuts and sugar onto the pancake. Fold the pancake into half once the bottom surface is browned.\r\n\r\nCut into wedges and best eaten when it is warm."
        let ingredients = [
            "Milk",
            "Oil",
            "Eggs",
            "Flour",
            "Baking Powder",
            "Salt",
            "Unsalted Butter",
            "Sugar",
            "Peanut Butter",
        ]
        let measures = [
            "200ml",
            "60ml",
            "2",
            "1600g",
            "3 tsp",
            "1/2 tsp",
            "25g",
            "45g",
            "3 tbs",
        ]
        
        return MealDetail(
            id: id,
            name: name,
            instructions: instructions,
            thumbnailURL: url,
            ingredients: ingredients,
            measures: measures
        )
    }()

    override func setUpWithError() throws {}
    override func tearDownWithError() throws {}

    func testGetMeals() async throws {
        
        let url = Bundle(for: Self.self).url(forResource: "mealdetails", withExtension: "json")
        let data = try Data(contentsOf: url!)
        
        MockURLProtocol.requestHandler = {
            request in
            
            XCTAssertEqual(request.url, URL(string: "https://themealdb.com/api/json/v1/1/lookup.php?i=53049"))
            
            let response = HTTPURLResponse(
                url: request.url!,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil
            )!
            
            return (response, data)
        }
        
        let id = 53049
        let name = "Apam balik"
        let thumbnailURL = URL(string: "https://www.themealdb.com//images//media//meals//adxcbq1619787919.jpg")!
        
        let meal = Meal(
            id: id,
            name: name,
            thumbnailURL: thumbnailURL
        )
        
        let sut = try await service.getMealDetail(meal: meal)
        
        XCTAssertEqual(sut.id, expected.id)
        XCTAssertEqual(sut.name, expected.name)
        XCTAssertEqual(sut.instructions, expected.instructions)
        XCTAssertEqual(sut.thumbnailURL, expected.thumbnailURL)
        XCTAssertEqual(sut.ingredients, expected.ingredients)
        XCTAssertEqual(sut.measures, expected.measures)
    }
}

