//
//  RecipeViewer.swift
//  Pizza Everything
//
//  Created by Tomas Van Roose on 16/08/2023.
//

import SwiftUI

private let formatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.maximumFractionDigits = 2
    return formatter
}()

let minSize = "0.01 g".size(withAttributes: [NSAttributedString.Key.font: UIFont.monospacedDigitSystemFont(ofSize: 17, weight: .bold)]).width


struct Row: View {
    let title: String
    let percentage: Float
    let gram: Float
    let colWidth: CGFloat
    
    
    init(_ title: String, _ percentage: Float, _ gram: Float, _ colWidth: CGFloat) {
        self.title = title
        self.percentage = percentage
        self.gram = gram
        self.colWidth = colWidth
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: 20) {
            Text(title)
            Spacer()
            Text("\(percentage as NSNumber, formatter: formatter)%")
            Text("\(gram as NSNumber, formatter: formatter) g")
                .foregroundColor(.secondary).bold()
                .frame(width: colWidth, alignment: .trailing)
            }
        .frame(maxWidth: .infinity)
    }
}

private func calcWidth(s: String) -> CGFloat {
    let gramSize = s.size(withAttributes: [NSAttributedString.Key.font: UIFont.monospacedDigitSystemFont(ofSize: 17, weight: .bold)]).width
    return max(gramSize, minSize)
}

struct RecipeViewer: View {
    var totalWeight: Float
    var recipe: Recipe

    var body: some View {
        
        let flour = recipe.calculateFlourFrom(totalWeigth: totalWeight)
        let colWidth = calcWidth(s: "\(formatter.string(from: flour as NSNumber)!) g")
        let calculatedRecipe = recipe.toValues(flourWeight: flour)
        
        VStack(alignment: .center, spacing: 5) {
            Text(recipe.title).font(.title).padding(.bottom)
            Row("Flour", 100, flour, colWidth)
            Row("Water", recipe.hydration, calculatedRecipe.hydration, colWidth)
            Row("Salt", recipe.salt, calculatedRecipe.salt, colWidth)
            Row("Fresh yeast", recipe.freshYeast, calculatedRecipe.freshYeast, colWidth)
            Row("Sugar", recipe.sugar, calculatedRecipe.sugar, colWidth)
            Row("Olive oil", recipe.oliveOil, calculatedRecipe.oliveOil, colWidth)
        }
        .padding()
        .background(.white)
        //.foregroundColor()
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.2), radius: 4)
        .monospacedDigit()
    }
}

struct RecipeViewer_Previews: PreviewProvider {
    static var total: Float = 250.0
    
    static var previews: some View {
        VStack {
            RecipeViewer(totalWeight: total, recipe: Recipe(title: "Experimentation", hydration: 65, salt: 3, freshYeast: 0.01, sugar: 1, oliveOil: 2))
                .padding()
            RecipeViewer(totalWeight: 10000, recipe: Recipe(title: "Experimentation", hydration: 65, salt: 3, freshYeast: 0.01, sugar: 1, oliveOil: 2))
                .padding()
        }
    }
}
