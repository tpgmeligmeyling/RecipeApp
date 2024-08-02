//
//  MealListItem.swift
//  RecipeApp
//
//  Created by Thomas Gmelig Meyling on 01/08/2024.
//

import Foundation

struct Meal: Identifiable, Hashable {
    
    var id: Int
    var name: String
    var thumbnailURL: URL

    init(id: Int, name: String, thumbnailURL: URL) {
        self.id = id
        self.name = name
        self.thumbnailURL = thumbnailURL
    }
}

extension Meal: Codable {
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let idString = try container.decode(String.self, forKey: .id)
        let id = if let id = Int(idString) {
            id
        } else {
            throw ServiceError.deserialization
        }
        self.init(
            id: id,
            name: try container.decode(String.self, forKey: .name),
            thumbnailURL: try container.decode(URL.self, forKey: .thumbnailURL)
        )
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case name = "strMeal"
        case thumbnailURL = "strMealThumb"
    }
}
