//
//  MealService.swift
//  RecipeApp
//
//  Created by Thomas Gmelig Meyling on 01/08/2024.
//

import Foundation
import UIKit

class MealService {
    
    let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func getMeals() async throws -> [Meal] {
        
        struct MealResponse: Decodable {
            let meals: [Meal]
        }
        
        guard var components = URLComponents(string: Constants.baseURL) else { throw ServiceError.invalidURL }
        components.path.append("filter.php")
        components.queryItems = [URLQueryItem(name: "c", value: "Dessert")]
        guard let mealURL = components.url else { throw ServiceError.invalidURL }
        
        
        let (data, _) = try await session.data(from: mealURL)
        let response = try JSONDecoder().decode(MealResponse.self, from: data)
        return response.meals
    }
}
