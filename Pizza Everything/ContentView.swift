//
//  ContentView.swift
//  Pizza Everything
//
//  Created by Tomas Van Roose on 14/08/2023.
//

import SwiftUI


struct ContentView: View {
    
    var body: some View {
        TabView {
            RecipeList(recipes: [])
            .padding()
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
