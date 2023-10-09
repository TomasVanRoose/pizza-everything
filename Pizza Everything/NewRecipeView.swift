//
//  NewRecipeView.swift
//  Pizza Everything
//
//  Created by Tomas Van Roose on 16/08/2023.
//

import SwiftUI



struct PickerSection: View {
    
    let title: String
    let image: Image
    @Binding var value: Float
    let range: ClosedRange<Float>
    let step: Float.Stride
    let precision: Int
    
    private let percentFormatter: NumberFormatter
    
    init(title: String, image: Image, value: Binding<Float>, range: ClosedRange<Float>, step: Float.Stride, precision: Int) {
        self.title = title
        self.image = image
        self._value = value
        self.range = range
        self.step = step
        self.precision = precision
        
        self.percentFormatter = {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            formatter.positiveSuffix = " %"
            formatter.minimumFractionDigits = precision
            return formatter
        }()
    }
    
    init(title: String, image: Image, value: Binding<Float>, range: ClosedRange<Float>, step: Float.Stride) {
        self.init(title: title, image: image, value: value, range: range, step: step, precision: 2)
    }
    
    
    var body: some View {
        Section(title) {
            HStack {
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit )
                    .frame(height: 17)
                    .foregroundStyle(.tint)
                TextField("", value: $value, formatter: percentFormatter)
                    .monospaced()
                    .keyboardType(.numberPad)
                    .frame(width: 70)
                Slider(value: $value, in: range, step: step)
            }
        }
    }
}

struct NewRecipeView: View {
    
    @Environment(\.dismiss) private var dismiss
    @State private var hydr: Float = 10
    @State private var draftRecipe = Recipe(title: "", hydration: 58, salt: 3, freshYeast: 0.55, sugar: 0, oliveOil: 0)

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    HStack(spacing: 10) {
                        Text("Title")
                            .frame(alignment: .trailing)
                            .bold()
                        Divider()
                        TextField("recipe title", text: $draftRecipe.title)
                            .textContentType(.familyName)
                    }
                }
                PickerSection(title: "Hydration", image: Image(systemName: "drop"), value: $draftRecipe.hydration, range: 50...100, step: 1, precision: 0)
                PickerSection(title: "Salt", image: Image(.salt), value: $draftRecipe.salt, range: 1...4, step: 0.01)
                PickerSection(title: "Yeast (fresh)", image: Image(.yeast), value: $draftRecipe.freshYeast, range: 0...4, step: 0.01)
                PickerSection(title: "Sugar", image: Image(.sugar), value: $draftRecipe.sugar, range: 0...4, step: 0.01)
                PickerSection(title: "Olive oil", image: Image(.oliveOil), value: $draftRecipe.oliveOil, range: 0...4, step: 0.01)

            }
            .tint(.red)
            .navigationTitle("Create a recipe template")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        dismiss()
                    }
                }
            }
        }
    }
}

struct NewRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        NewRecipeView()
    }
}
