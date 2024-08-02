//
//  MealListViewModel.swift
//  RecipeApp
//
//  Created by Thomas Gmelig Meyling on 01/08/2024.
//

import Foundation
import SwiftUI

@MainActor
class MealListViewModel: ObservableObject {
    
    @Published var meals: [Meal] = []
    let service: MealService
    
    init(service: MealService = .init()) {
        self.service = service
    }
    
    func loadMeals() async throws {
        self.meals = try await service.getMeals()
    }
    
    func listRowViewModel(for meal: Meal) -> MealListRowViewModel {
        MealListRowViewModel(meal: meal)
    }
    
    func detailViewModel(for meal: Meal) -> MealDetailViewModel {
        MealDetailViewModel(meal: meal)
    }
}
