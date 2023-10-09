//
//  FlourrShape.swift
//  Pizza Everything
//
//  Created by Tomas Van Roose on 28/09/2023.
//

import SwiftUI

struct FlourrShape: View {
    var body: some View {
        Path { path in
            let width: CGFloat = 100.0
            let height = width
            path.move(to: CGPoint(x: 0, y: height * 0.2))
            path.addLine(to: CGPoint(x: 0, y: height))
            path.addLine(to: CGPoint(x: width, y: height))
            path.addLine(to: CGPoint(x: width, y: height * 0.2))
        }
        .stroke(lineWidth: 1)
    }
}

#Preview {
    FlourrShape().padding()
}
