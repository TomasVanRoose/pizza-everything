//
//  Recipe.swift
//  Pizza Everything
//
//  Created by Tomas Van Roose on 16/08/2023.
//

import SwiftUI

@Observable final class Recipe: Identifiable {
    
    var id = UUID()
    var title: String
    var hydration: Float
    var salt: Float
    var freshYeast: Float
    var sugar: Float
    var oliveOil: Float
    
    init(title: String, hydration: Float, salt: Float, freshYeast: Float, sugar: Float, oliveOil: Float) {
        self.title = title
        self.hydration = hydration
        self.salt = salt
        self.freshYeast = freshYeast
        self.sugar = sugar
        self.oliveOil = oliveOil
    }
}

extension Recipe {
    func calculateFlourFrom(totalWeigth: Float) -> Float {
        return totalWeigth / ((hydration/100) + 1)
    }
    func toValues(flourWeight: Float) -> Recipe {
        return Recipe (
            title: self.title,
            hydration: (self.hydration / 100) * flourWeight,
            salt: (self.salt / 100) * flourWeight,
            freshYeast: (self.freshYeast / 100) * flourWeight,
            sugar: (self.sugar / 100) * flourWeight,
            oliveOil: (self.oliveOil / 100) * flourWeight
        )
    }
}
