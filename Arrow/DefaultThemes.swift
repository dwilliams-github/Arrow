//
//  DefaultColors.swift
//  Arrow
//
//  Created by David Williams on 12/3/20.
//  Copyright © 2020 David Williams. All rights reserved.
//
import SwiftUI

extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red:   Double((hex >> 16) & 0xff) / 0xff,
            green: Double((hex >>  8) & 0xff) / 0xff,
            blue:  Double((hex >>  0) & 0xff) / 0xff,
            opacity: alpha
        )
    }
}

// This is just to make the list included below a little more compact
extension ArrowTheme {
    init(hex: [UInt]) {
        self.init(
            backgroundColor: Color(hex: hex[0]),
            onColor:         Color(hex: hex[1]),
            offColor:        Color(hex: hex[2]),
            controlColor:    Color(hex: hex[3])
        )
    }
}

struct DefaultThemes {
    static let choices = [
        // See colors.sketch
        //                back      on        off       ctrl
        ArrowTheme(hex: [0x000000, 0xF1C100, 0x000000, 0x838282]),  // Default
        ArrowTheme(hex: [0x000000, 0xF1C100, 0x484646, 0x838282]),
        ArrowTheme(hex: [0x000000, 0xFF4500, 0x000000, 0x838282]),
        ArrowTheme(hex: [0x000000, 0xFF4500, 0x484646, 0x838282]),
        ArrowTheme(hex: [0x000000, 0x00FF86, 0x000000, 0x838282]),
        ArrowTheme(hex: [0x000000, 0x00FF86, 0x484646, 0x838282]),

        ArrowTheme(hex: [0x01735C, 0xFF9A00, 0x1F6557, 0x383838]),  // road sign green
        ArrowTheme(hex: [0x01735C, 0xFFFFFF, 0x02886C, 0xC1BDBD]),

        ArrowTheme(hex: [0x353535, 0xFF0000, 0x202020, 0x838282]),  // red
        ArrowTheme(hex: [0xEDEDED, 0x323232, 0xF7F7F7, 0x838282]),  // negative
    ]
}
