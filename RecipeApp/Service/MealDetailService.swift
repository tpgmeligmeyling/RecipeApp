//
//  MealDetailService.swift
//  RecipeApp
//
//  Created by Thomas Gmelig Meyling on 01/08/2024.
//

import Foundation

class MealDetailService {
    
    let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func getMealDetail(meal: Meal) async throws -> MealDetail {
        
        struct MealDetailResponse: Decodable {
            let meals: [MealDetail]
        }
         
        guard var components = URLComponents(string: Constants.baseURL) else { throw ServiceError.invalidURL }
        components.path.append("lookup.php")
        components.queryItems = [URLQueryItem(name: "i", value: "\(meal.id)")]
        guard let mealURL = components.url else { throw ServiceError.invalidURL }
        
        let (data, _) = try await session.data(from: mealURL)
        let response = try JSONDecoder().decode(MealDetailResponse.self, from: data)
        guard let mealDetail = response.meals.first else { throw ServiceError.deserialization }
        return mealDetail
    }
}
