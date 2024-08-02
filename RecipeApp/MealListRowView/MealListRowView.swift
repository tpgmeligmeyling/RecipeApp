//
//  MealListRowView.swift
//  RecipeApp
//
//  Created by Thomas Gmelig Meyling on 01/08/2024.
//

import Foundation
import SwiftUI

@MainActor
struct MealListRowView: View {
    
    @ObservedObject var viewModel: MealListRowViewModel
    
    var body: some View {
        HStack {
            AsyncImage(url: viewModel.thumbnailURL) {
                image in
                image.image?.resizable()
            }
            .frame(width: 60, height: 60)
            Text(viewModel.title)
                .padding(.leading)
                .font(.title2)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
