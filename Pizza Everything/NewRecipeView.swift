//
//  NewRecipeView.swift
//  Pizza Everything
//
//  Created by Tomas Van Roose on 16/08/2023.
//

import SwiftUI

struct NewRecipeView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var fresh = true
    @State private var title = ""
    @State private var hydration: Float = 65
    @State private var salt: Float = 3
    @State private var freshYeast: Float = 0.55
    @State private var dryYeast: Float = 1.55
    @State private var sugar: Float = 1
    @State private var oliveOil: Float = 2
    
    var body: some View {
        
        let hydrationTile = IngredientSelectionTile(title: "Hydration", minVal: 50, maxVal: 100, unit: "%", precision: 2, value: $hydration)
        let saltTile = IngredientSelectionTile(title: "Salt", minVal: 1, maxVal: 4, unit: "%", precision: 2, value: $salt)
        let freshYeastTile = IngredientSelectionTile(title: "", minVal: 0.01, maxVal: 1, unit: "%", precision: 2, value: $freshYeast)
        let dryYeastTile = IngredientSelectionTile(title: "", minVal: 0.01, maxVal: 3, unit: "%", precision: 2, value: $dryYeast)
        let sugarTile = IngredientSelectionTile(title: "Sugar", minVal: 0, maxVal: 4, unit: "%", precision: 2, value: $sugar)
        let oliveOilTile = IngredientSelectionTile(title: "Olive oil", minVal: 0, maxVal: 4, unit: "%", precision: 2, value: $oliveOil)
        
        NavigationStack {
            VStack(alignment: .leading) {
                Text("Create a recipe")
                    .font(.title)
                    .padding(.bottom)
                    .frame(maxWidth: .infinity, alignment: .center)
                TextField("Recipe title", text: $title).padding(.bottom)
                hydrationTile
                saltTile
                Picker("", selection: $fresh) {
                    Text("Fresh yeast").tag(true)
                    Text("Dry yeast").tag(false)
                }
                .pickerStyle(.segmented)
                .padding(.top)
                fresh ? freshYeastTile : dryYeastTile
                sugarTile
                oliveOilTile
                
                Spacer()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        dismiss()
                    }
                }
            }
            .padding()

        }
    }
}

struct NewRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        NewRecipeView()
    }
}
