//
//  RecipeList.swift
//  Pizza Everything
//
//  Created by Tomas Van Roose on 16/08/2023.
//

import SwiftUI

struct RecipeList: View {
    var recipes: [Recipe]
    
    @State private var numberOfBalls: Float = 1
    @State private var totalWeight: Float = 250
    @State private var showNewRecipe = false
    
    var body: some View {
        NavigationView {
            VStack {
                IngredientSelectionTile(title: "Number of doughs", minVal: 1, maxVal: 10, unit: "", value: $numberOfBalls).padding(.horizontal)
                IngredientSelectionTile(title: "Weight of 1 pizza dough", minVal: 100, maxVal: 350, unit: "g", value: $totalWeight)
                    .padding(.horizontal)
                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(recipes, id: \.self) { recipe in
                            RecipeViewer(totalWeight: totalWeight * numberOfBalls, recipe: recipe)
                        }
                    }.padding()
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showNewRecipe.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showNewRecipe) {
                NewRecipeView()
            }
        }
    }
}

struct RecipeList_Previews: PreviewProvider {
    static let recipes = [
        Recipe(title: "Experimentation", hydration: 65, salt: 3, freshYeast: 0.01, sugar: 1, oliveOil: 2),
        Recipe(title: "Enzo", hydration: 60, salt: 2.6, freshYeast: 0.03, sugar: 1, oliveOil: 2),
        Recipe(title: "12 hour", hydration: 70, salt: 3, freshYeast: 0.01, sugar: 1, oliveOil: 2)
    ]
    
    static var previews: some View {
            RecipeList(recipes: recipes)
    }
}
