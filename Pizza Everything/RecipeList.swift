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
            ScrollView {
                VStack {
                    GeometryReader { geometry in
                        var minY = geometry.frame(in: .global).minY
                        var moveWithImageOffset = minY > 0 ? -minY : (minY < -120 ? -minY - 120 : 0)
                        
                        ZStack(alignment: .bottomLeading) {
                            Image(.pizzaHeader)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .bottomBlur()
                                .offset(y: moveWithImageOffset)
                                .frame(width: geometry.size.width,  height: geometry.size.height + (minY > 0 ? minY : 0))
                            
                            VStack(alignment: .leading) {
                                Text("Pizza")
                                    .font(.largeTitle)
                                    .bold()
                                    .foregroundStyle(.white)
                                Text("Flour, Water, Yeast, Salt")
                                    .foregroundStyle(.white)
                                    .opacity(0.8)
                            }
                            .offset(y: -50 + moveWithImageOffset)
                            .padding()
                            
                            Button {
                                showNewRecipe.toggle()
                
                            } label: {
                                Image(systemName: "plus")
                                    .foregroundStyle(.gray)
                                    .padding(3)
                                    .background(.white)
                                    .clipShape(Circle())
                            }
                            .offset(x: geometry.size.width - 50, y: -geometry.size.height + 85)
                            .offset(y: minY > 0 ? -minY-minY : -minY)
                        }.overlay(alignment: .bottom) {
                            VStack {
                                Stepper(value: $numberOfBalls) {
                                    Text("\(Int(numberOfBalls))").bold().underline() + Text(" dough balls")
                                }
                                HStack {
                                    Text("\(Int(totalWeight))").bold().underline() + Text(" g")
                                    Spacer()
                                    Slider(value: $totalWeight, in: 100...350, step: 1) {
                                        Text("total weight")
                                    }.frame(maxWidth: geometry.size.width * 0.7)
                                }
                            }
                            .padding()
                            .background(.thinMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 25))
                            .padding(.horizontal)
                            .offset(y: 50 + moveWithImageOffset)
                        }
                    }
                    .frame(height: 300)
                    .shadow(radius: 4)
                    .zIndex(2)
                    .padding(.bottom, 50)
                    
                    VStack(spacing: 20) {
                        ForEach(recipes) { recipe in
                            RecipeViewer(totalWeight: totalWeight * numberOfBalls, recipe: recipe)
                        }
                    }.padding()
                }
                
            }
            .ignoresSafeArea(.container, edges: .top)
            .statusBar(hidden: true)
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
