//
//  RecipeTemplateCard.swift
//  Pizza Everything
//
//  Created by Tomas Van Roose on 09/10/2023.
//

import SwiftUI

private let formatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.maximumFractionDigits = 2
    return formatter
}()

struct RecipeTemplateCard: View {
    
    let template: Recipe
    
    var body: some View {
        VStack() {
            Text(template.title)
                .font(.title)
                .bold()
                .padding([.horizontal, .bottom])
            HStack {
                Label("Hydration", systemImage: "drop")
                Spacer()
                Text("\(template.hydration as NSNumber, formatter: formatter) %")
            }
            HStack {
                Label(title: {
                    Text("Salt")
                }, icon: {
                    Image(.salt)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 20)
                })
                Spacer()
                Text("\(template.salt as NSNumber, formatter: formatter) %")
            }
            HStack {
                Label(title: {
                    Text("Fresh yeast")
                }, icon: {
                    Image(.yeast)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 20)
                })               
                Spacer()
                Text("\(template.freshYeast as NSNumber, formatter: formatter) %")
            }
            if template.sugar > 0 {
                HStack {
                    Label(title: {
                        Text("Sugar")
                    }, icon: {
                        Image(.sugar)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 20)
                    })                    
                    Spacer()
                    Text("\(template.sugar as NSNumber, formatter: formatter) %")
                }
            }
            if template.oliveOil > 0 {
                HStack {
                    Label(title: {
                        Text("Olive oil")
                    }, icon: {
                        Image(.oliveOil)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 20)
                    })
                    Spacer()
                    Text("\(template.oliveOil as NSNumber, formatter: formatter) %")
                }
            }
        }
        .padding()
        .padding(.horizontal)
        .foregroundStyle(.white)
        .font(.system(size: 20))
        .frame(maxWidth: .infinity)
        .background {
            LinearGradient(colors: [Color(#colorLiteral(red: 1, green: 0.4992411137, blue: 0.4899398088, alpha: 1)), Color(#colorLiteral(red: 1, green: 0.1768808626, blue: 0.3151895794, alpha: 1))], startPoint: .bottomLeading, endPoint: .topTrailing)
        }
        .clipShape(.rect(cornerRadius: 20))
        .shadow(radius: 10)
    }
}

#Preview {
    RecipeTemplateCard(template: Recipe(title: "Home Oven Recipe", hydration: 67, salt: 3, freshYeast: 0.4, sugar: 1, oliveOil: 2))
        .padding()
}
