//
//  MealDetailView.swift
//  RecipeApp
//
//  Created by Thomas Gmelig Meyling on 01/08/2024.
//

import Foundation
import SwiftUI

@MainActor
struct MealDetailView: View {
    
    @ObservedObject var viewModel: MealDetailViewModel
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: viewModel.thumbnailURL) {
                    image in
                    image.image?
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                .ignoresSafeArea()
                .frame(maxWidth: .infinity)
                VStack {
                    Text("Ingredients")
                        .font(.title2)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    ForEach(Array(viewModel.ingredientsAndMeasures.enumerated()), id: \.0) {
                        let (ingredient, measure) = $0.element
                        Text(verbatim: "• \(ingredient) - \(measure)")
                            .multilineTextAlignment(.leading)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    Color.clear.padding(.top)
                    Text("Instructions")
                        .font(.title2)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    if let details = viewModel.mealDetail {
                        Text(verbatim: details.instructions)
                            .font(.body)
                    }
                }
                .padding()
                Color.clear
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .task {
            await viewModel.loadDetailsIfNeeded()
        }
        .navigationTitle(viewModel.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}
