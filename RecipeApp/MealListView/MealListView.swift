//
//  MealListView.swift
//  RecipeApp
//
//  Created by Thomas Gmelig Meyling on 01/08/2024.
//

import Foundation
import SwiftUI

@MainActor
struct MealListView: View {
    
    @ObservedObject var viewModel: MealListViewModel
    
    var body: some View {
        List {
            ForEach(viewModel.meals) {
                meal in
                NavigationLink(value: meal) {
                    MealListRowView(viewModel: viewModel.listRowViewModel(for: meal))
                }
                .listRowSeparator(.visible)
                .accessibilityIdentifier("mealRow\(meal.name)")
            }
        }
        .navigationDestination(for: Meal.self, destination: {
            meal in
            MealDetailView(viewModel: viewModel.detailViewModel(for: meal))
        })
        .navigationTitle("Desserts")
        .task {
            do {
                try await viewModel.loadMeals()
            } catch {
                print(error)
                // TODO: Probably want error handling here in the future.
            }
        }
    }
}
