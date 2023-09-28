//
//  ContourPath.swift
//  Pizza Everything
//
//  Created by Tomas Van Roose on 24/09/2023.
//

import SwiftUI

struct CurvedSegmentPoints {
    var from: CGPoint
    var to: CGPoint
    var control1: CGPoint
    var control2: CGPoint
}

struct Line {
    var length: CGFloat
    var angle: Angle
    
    init(_ point1: CGPoint, _ point2: CGPoint) {
        let x = point2.x - point1.x
        let y = point2.y - point1.y
        self.length = ((x * x) + (y * y)).squareRoot()
        self.angle = Angle.radians(atan2(y, x))
    }
}

func controlPoint(_ currentPoint : CGPoint, previousPoint: CGPoint?, nextPoint: CGPoint?, reversed: Bool = false) -> CGPoint {
    let previous = previousPoint ?? currentPoint
    let next = nextPoint ?? currentPoint
    
    let smoothing = 0.2
    
    let opposedLine = Line(previous, next)
    let angle = opposedLine.angle + Angle.radians(reversed ? Double.pi : 0)
    let length = opposedLine.length * smoothing
    
    return CGPoint(x: currentPoint.x + (cos(angle.radians) * length), y: currentPoint.y + (sin(angle.radians) * length))
}

struct CurvedPathSegment: Shape {
    let points: [CGPoint]
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            for i in points.indices {
                let current = points[i]
                if i == 0 {
                    path.move(to: current)
                    continue
                }
                let previous = points[i - 1]
                let preprevious = i < 2 ? nil : points[i - 2]
                let next = i < points.count - 1 ? points[i + 1] : nil
                
                let control1 = controlPoint(previous, previousPoint: preprevious, nextPoint: current)
                let control2 = controlPoint(current, previousPoint: previous, nextPoint: next, reversed: true)

                path.addCurve(to: current, control1: control1, control2: control2)
            }
            let count = points.count
            if count > 4 {
                let control1 = controlPoint(points[count - 1], previousPoint: points[count - 2], nextPoint: points[0])
                let control2 = controlPoint(points[0], previousPoint: points[count - 1], nextPoint: points[1], reversed: true)
                path.addCurve(to: points[0], control1: control1, control2: control2)
            }
        }
    }
}

struct ContourPath: View {
    @GestureState var circleLocation: CGPoint?
    
    @State var points: [CGPoint] = []
    @State var firstDrawing = true
    @State var draggingIdx: Int?
    
    var drag: some Gesture {
        DragGesture()
            .onChanged { value in
                if firstDrawing {
                    if let lastPoint = points.last {
                        if value.location.distanceSquared(to: lastPoint) >= 5000 {
                            self.points.append(value.location)
                        }
                    } else {
                        self.points.append(value.startLocation)
                    }
                }
            }
            .updating($circleLocation) { (value, circleLocation, _) in
                circleLocation = value.location
            }.onEnded { _ in
                firstDrawing = false
            }
    }
    
    var otherDrag: some Gesture { 
        DragGesture()
            .onChanged { value in
                if firstDrawing {
                    return
                }
                if let draggingIdx = self.draggingIdx {
                    self.points[draggingIdx] = value.location
                } else {
                    if let firstIdx = self.points.firstIndex(where: { point in
                        point.distanceSquared(to: value.location) < 500
                    }) {
                        self.draggingIdx = firstIdx
                    }
                }
            }
            .onEnded { _ in
                self.draggingIdx = nil
            }
    }
    var body: some View {
        NavigationView {
            ZStack {
                CurvedPathSegment(points: self.points).stroke(.red, lineWidth: 5)
                ForEach(points, id: \.self) { point in
                    Circle()
                        .fill(.red)
                        .stroke(.white, lineWidth: 1)
                        .frame(width: 10, height: 10)
                        .position(point)
                }
                if let cl = circleLocation {
                    Circle()
                        .fill(Color.blue)
                        .frame(width: 20, height: 20)
                        .position(cl)
                }
            }
        }
        .gesture(otherDrag)
        .simultaneousGesture(drag)
        .onTapGesture(count: 2) {
            points.removeAll()
            firstDrawing = true
        }
    }
}

extension CGPoint {
    func distanceSquared(to: CGPoint) -> CGFloat {
            return (self.x - to.x) * (self.x - to.x) + (self.y - to.y) * (self.y - to.y)
    }
}
extension CGPoint : Hashable {
  public func hash(into hasher: inout Hasher) {
    hasher.combine(x)
    hasher.combine(y)
  }
}

#Preview {
    ContourPath()
}
