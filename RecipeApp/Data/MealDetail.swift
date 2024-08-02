//
//  MealDetail.swift
//  RecipeApp
//
//  Created by Thomas Gmelig Meyling on 01/08/2024.
//

import Foundation

struct MealDetail {
    
    let id: Int
    let name: String
    let instructions: String
    let thumbnailURL: URL
    let ingredients: [String]
    let measures: [String]
    
    init(
        id: Int,
        name: String,
        instructions: String,
        thumbnailURL: URL,
        ingredients: [String],
        measures: [String]
    ) {
        self.id = id
        self.name = name
        self.instructions = instructions
        self.thumbnailURL = thumbnailURL
        self.ingredients = ingredients
        self.measures = measures
    }
}

extension MealDetail: Decodable {
    
    init(from decoder: any Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let idString = try container.decode(String.self, forKey: .id)
        let id = if let id = Int(idString) {
            id
        } else {
            throw ServiceError.deserialization
        }
        
        let ingrediensContainer = try decoder.container(keyedBy: IngredientCodingKeys.self)
        let ingredients: [String] = IngredientCodingKeys.allCases
            .compactMap { try? ingrediensContainer.decodeIfPresent(String.self, forKey: $0) }
            .filter { $0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == false }
        
        let measuresContainer = try decoder.container(keyedBy: MeasureCodingKeys.self)
        let measures: [String] = MeasureCodingKeys.allCases
            .compactMap { try? measuresContainer.decodeIfPresent(String.self, forKey: $0) }
            .filter { $0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == false }
        
        self.init(
            id: id,
            name: try container.decode(String.self, forKey: .name),
            instructions: try container.decode(String.self, forKey: .instructions),
            thumbnailURL: try container.decode(URL.self, forKey: .thumbnailURL),
            ingredients: ingredients,
            measures: measures
        )
    }
    
    enum CodingKeys: String, CodingKey {
        
        case id = "idMeal"
        case name = "strMeal"
        case instructions = "strInstructions"
        case thumbnailURL = "strMealThumb"
    }
    
    private struct MeasureCodingKeys: CodingKey, CaseIterable {
        
        static var allCases: [MeasureCodingKeys] = {
            (1...20).map { Self.init(intValue: $0) }
        }()
        
  
        var stringValue: String
        var intValue: Int? = nil
        
        init(intValue id: Int) {
            stringValue = "strMeasure\(id)"
        }
        
        init?(stringValue: String) {
            if let value = Self.allCases
                .first(where: { $0.stringValue == stringValue }) {
                self = value
            } else {
                return nil
            }
        }
    }
    
    private struct IngredientCodingKeys: CodingKey, CaseIterable {
        
        static var allCases: [IngredientCodingKeys] = {
            (1...20).map { Self.init(intValue: $0) }
        }()
        
  
        var stringValue: String
        var intValue: Int? = nil
        
        init(intValue id: Int) {
            stringValue = "strIngredient\(id)"
        }
        
        init?(stringValue: String) {
            if let value = Self.allCases
                .first(where: { $0.stringValue == stringValue }) {
                self = value
            } else {
                return nil
            }
        }
    }
}
