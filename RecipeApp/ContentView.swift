//
//  ContentView.swift
//  RecipeApp
//
//  Created by Thomas Gmelig Meyling on 01/08/2024.
//

import SwiftUI

@MainActor
struct ContentView: View {
    var body: some View {
        NavigationStack {
            MealListView(
                viewModel: MealListViewModel()
            )
        }
    }
}

#Preview {
    ContentView()
}
