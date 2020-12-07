//
//  ArrowBoardView.swift
//  Arrow
//
//  Created by David Williams on 11/14/20.
//  Copyright © 2020 David Williams. All rights reserved.
//
import SwiftUI

struct ArrowBoardView: View {
    let geometry: ArrowGeometry
    let theme: ArrowTheme
    @ObservedObject var frame: ArrowFrame
    @ObservedObject var pattern: ArrowPattern
    
    var body: some View {
        GeometryReader { viewGeom in
            let width = geometry.BulbDiameter(enclosureSize: viewGeom.size)

            ZStack {
                ForEach(0..<geometry.number) { seq in
                    let loc = geometry.Position(bulb: seq, enclosureSize: viewGeom.size)
                    
                    Circle()
                        .fill(pattern.BulbIsLit(bulb: seq, tick: frame.tick) ? theme.onColor : theme.offColor)
                        .frame(width: width, height: width)
                        .position(x: loc.x, y: loc.y)
                        .animation(Animation.default.speed(1))
                }
            }
        }
    }
}
