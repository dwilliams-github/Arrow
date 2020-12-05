//
//  ArrowPattern.swift
//  Arrow
//
//  Created by David Williams on 12/2/20.
//  Copyright © 2020 David Williams. All rights reserved.
//
import SwiftUI

class ArrowPattern : ObservableObject {
    var frames: [Int32]
    
    init(frames: [Int32]) {
        self.frames = frames
    }
    
    func BulbIsLit(bulb: Int, tick: Int) -> Bool {
        return self.frames[tick % self.frames.count] & (1<<bulb) != 0
    }
}


/**
Arrow annimation frame to display
*/
class ArrowFrame: ObservableObject {
    @Published var tick: Int = 0
}
