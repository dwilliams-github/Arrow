//
//  AnimatedArrowBoardView.swift
//  Arrow
//
//  Created by David Williams on 11/30/20.
//  Copyright © 2020 David Williams. All rights reserved.
//
import SwiftUI

class ArrowClock : ArrowFrame {
    var timer : Timer?
    
    init(every: TimeInterval) {
        super.init()
        timer = Timer.scheduledTimer( withTimeInterval: every, repeats: true ) {timer in
            self.tick += 1
        }
    }
}

struct AnimatedArrowBoardView: View {
    @ObservedObject var settings: ArrowSettings
    
    var body: some View {
        ArrowBoardView(
            geometry: settings.geometry,
            theme: settings.Theme(),
            frame: ArrowClock(every: settings.interval),
            pattern: settings.Pattern()
        )
    }
}
