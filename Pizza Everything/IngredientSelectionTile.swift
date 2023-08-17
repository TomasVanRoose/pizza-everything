//
//  IngredientSelectionTile.swift
//  Pizza Everything
//
//  Created by Tomas Van Roose on 16/08/2023.
//

import SwiftUI

struct IngredientSelectionTile: View {
    let title: String
    let minVal: Float
    let maxVal: Float
    let unit: String
    let precision: Int
    
    @Binding var value: Float
    
    init(title: String, minVal: Float, maxVal: Float, unit: String, precision: Int = 0, value: Binding<Float>) {
        self.title = title
        self.minVal = minVal
        self.maxVal = maxVal
        self.unit = unit
        self.precision = precision
        self._value = value
    }
    
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    let width = "12.45".size(withAttributes: [NSAttributedString.Key.font: UIFont.monospacedDigitSystemFont(ofSize: 17, weight: .regular)]).width

    
    var body: some View {
        VStack {
            Text(title)
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
                HStack {
                    VStack {
                        HStack {
                            Text("\(minVal as NSNumber, formatter: formatter)\(unit)")
                            Spacer()
                            Text("\(maxVal as NSNumber, formatter: formatter)\(unit)")
                        }
                        Slider(value: $value,
                               in: minVal...maxVal,
                               step: pow(10, -Float(precision))) {
                            Text(title)
                        }
                    }
                    Spacer(minLength: 30)
                    TextField("", value: $value, formatter: formatter)
                        .foregroundColor(.white)
                        .frame(width: width)
                        .padding()
                        .multilineTextAlignment(.center)
                        .background(.purple.opacity(0.75), in: Capsule())
                        .keyboardType(.decimalPad)
                        .fixedSize(horizontal: true, vertical: true)
                    Text(unit)
                }.monospacedDigit()
        }
    }
}

struct IngredientSelectionTile_Previews: PreviewProvider {
    
    struct TileContainer: View {
        @State private var value: Float = 250
        @State private var smol: Float = 0.5
        var body: some View {
            VStack {
                Spacer()
                IngredientSelectionTile(title: "Weight", minVal: 100, maxVal: 350, unit: "g", value: $value)
                Spacer()
                IngredientSelectionTile(title: "Yeast", minVal: 0.01, maxVal: 3, unit: "%", precision: 2, value: $smol)
                Spacer()
            }.padding()
        }
    }
    
    static var previews: some View {
        TileContainer()
    }
}
