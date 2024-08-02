//
//  MealListRowViewModel.swift
//  RecipeApp
//
//  Created by Thomas Gmelig Meyling on 01/08/2024.
//

import Foundation

@MainActor
class MealListRowViewModel: ObservableObject {
    
    let meal: Meal
    
    init(meal: Meal) {
        self.meal = meal
    }
    
    var title: String {
        meal.name
    }
    
    var thumbnailURL: URL {
        meal.thumbnailURL
    }
}
