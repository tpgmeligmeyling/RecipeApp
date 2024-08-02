//
//  MealDetailViewModel.swift
//  RecipeApp
//
//  Created by Thomas Gmelig Meyling on 01/08/2024.
//

import Foundation
import SwiftUI

@MainActor
class MealDetailViewModel: ObservableObject {
    
    enum State {
        case shouldLoad(meal: Meal)
        case isLoading(meal: Meal)
        case loaded(meal: MealDetail)
        case failedLoading(meal: Meal, error: Error)
    }
    
    @Published var state: State
    private let mealDetailService: MealDetailService
    
    init(meal: Meal, mealDetailService: MealDetailService = MealDetailService()) {
        self.state = .shouldLoad(meal: meal)
        self.mealDetailService = mealDetailService
    }
    
    func loadDetailsIfNeeded() async {
        guard case .shouldLoad(let meal) = state else { return }
        do {
            state = .isLoading(meal: meal)
            let mealDetail = try await mealDetailService.getMealDetail(meal: meal)
            state = .loaded(meal: mealDetail)
        } catch {
            state = .failedLoading(meal: meal, error: error)
        }
    }
    
    var title: String {
        return switch mealOrDetail {
        case .meal(let meal): meal.name
        case .detail(let detail): detail.name
        }
    }
    
    var thumbnailURL: URL {
        return switch mealOrDetail {
        case .meal(let meal): meal.thumbnailURL
        case .detail(let detail): detail.thumbnailURL
        }
    }
    
    var isLoading: Bool {
        guard case .isLoading = state else { return false }
        return true 
    }
    
    var mealDetail: MealDetail? {
        return switch state {
        case .loaded(meal: let detail): detail
        default: nil
        }
    }
    
    var ingredientsAndMeasures: [(String, String)] {
        guard let mealDetail else { return [] }
        return zip(mealDetail.ingredients, mealDetail.measures)
            .map { ($0, $1) }
    }
}

private extension MealDetailViewModel {
    
    private enum MealOrDetail {
        case meal(Meal)
        case detail(MealDetail)
    }
    
    private var mealOrDetail: MealOrDetail {
        return switch state {
        case .shouldLoad(meal: let meal): .meal(meal)
        case .isLoading(meal: let meal): .meal(meal)
        case .failedLoading(meal: let meal, error: _): .meal(meal)
        case .loaded(meal: let detail): .detail(detail)
        }
    }
}
