//
//  ContentView.swift
//  Pizza Everything
//
//  Created by Tomas Van Roose on 14/08/2023.
//

import SwiftUI

struct BottomBlur: ViewModifier {
    var height: CGFloat? = 130
    func body(content: Content) -> some View {
        content
            .overlay(alignment: .bottomLeading) {
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .mask {
                        LinearGradient(colors: [Color.black.opacity(0),
                                                Color.black.opacity(0.5),
                                                Color.black.opacity(1.5)],
                                       startPoint: .top,
                                       endPoint: .bottom)
                    }.frame(height: height)
            }
    }
}

extension View {
    func bottomBlur(height: CGFloat) -> some View {
        modifier(BottomBlur(height: height))
    }
    func bottomBlur() -> some View {
        modifier(BottomBlur())
    }
}

struct ContentView: View {
    
    var body: some View {
        TabView {
            RecipeList(recipes: [Recipe(title: "Experimentation", hydration: 65, salt: 3, freshYeast: 0.01, sugar: 1, oliveOil: 2),
                                 Recipe(title: "Enzo", hydration: 60, salt: 2.6, freshYeast: 0.03, sugar: 1, oliveOil: 2),
                                 Recipe(title: "12 hour", hydration: 70, salt: 3, freshYeast: 0.01, sugar: 1, oliveOil: 2)
                                ])
            .tabItem {
                Label("Recipes", systemImage: "newspaper")
            }
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
