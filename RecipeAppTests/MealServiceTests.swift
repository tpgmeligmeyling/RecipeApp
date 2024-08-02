//
//  MealServiceTests.swift
//  RecipeAppTests
//
//  Created by Thomas Gmelig Meyling on 01/08/2024.
//

import XCTest
@testable import RecipeApp

final class MealServiceTests: XCTestCase {
    
    lazy var session: URLSession = {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        return URLSession(configuration: configuration)
    }()
    
    lazy var service = MealService(session: session)

    override func setUpWithError() throws {}
    override func tearDownWithError() throws {}

    func testGetMeals() async throws {
        
        let url = Bundle(for: Self.self).url(forResource: "meals", withExtension: "json")
        let data = try Data(contentsOf: url!)
        
        MockURLProtocol.requestHandler = {
            request in
            
            XCTAssertEqual(request.url, URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert"))
            
            let response = HTTPURLResponse(
                url: request.url!,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil
            )!
            
            return (response, data)
        }
        
        let meals = try await service.getMeals()
        
        XCTAssertTrue(meals.isEmpty == false)
        
        let id = 53049
        let name = "Apam balik"
        let thumbnailURL = URL(string: "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg")!
        
        XCTAssertEqual(meals.first?.id, id)
        XCTAssertEqual(meals.first?.name, name)
        XCTAssertEqual(meals.first?.thumbnailURL, thumbnailURL)
    }
}
