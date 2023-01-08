//
//  UserSettings.swift
//  Arrow
//
//  Created by David Williams on 11/15/20.
//  Copyright © 2020 David Williams. All rights reserved.
//
import SwiftUI

/**
 A codable RGB color

 Unfortunately, Color is not Codable (in its current form).
 This is a workaround
 
 - Note: As of iOS 14, UIColor is codable and directly convertable, so the code below
 might not be an optimal solution
 */
struct CodableColor : Codable {
    var r: Double
    var g: Double
    var b: Double
    var alpha: Double
    
    /**
     Return equivalent Color
     
     - Returns: The swiftui Color
     */
    func ToColor() -> Color {
        Color( .sRGB, red: r, green: g, blue: b, opacity: alpha )
    }
    
    /**
     Initialize from a swiftui Color
     
     - Parameter color: The associated swiftui Color
     */
    init(_ color: Color) {
        var cgr: CGFloat = 0
        var cgg: CGFloat = 0
        var cgb: CGFloat = 0
        var cga: CGFloat = 1
        UIColor(color).getRed(&cgr, green: &cgg, blue: &cgb, alpha: &cga)
        self.r = Double(cgr)
        self.g = Double(cgg)
        self.b = Double(cgb)
        self.alpha = Double(cga)
    }
}

/**
 Codable wrapper around ArrowTheme
 
 This is a simple wrapper that allows us to store ArrowTheme
 in UserDefaults
 */
struct CodableArrowTheme : Codable {
    var theme: ArrowTheme
    
    enum CodingKeys: String, CodingKey {
        case back
        case on
        case off
        case ctrl
    }
    
    init(original: ArrowTheme) {
        self.theme = original
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        theme = ArrowTheme(
            backgroundColor: try container.decode(CodableColor.self, forKey: .back).ToColor(),
            onColor:         try container.decode(CodableColor.self, forKey: .on  ).ToColor(),
            offColor:        try container.decode(CodableColor.self, forKey: .off ).ToColor(),
            controlColor:    try container.decode(CodableColor.self, forKey: .ctrl).ToColor()
        )
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(CodableColor(theme.backgroundColor), forKey: .back)
        try container.encode(CodableColor(theme.onColor), forKey: .on)
        try container.encode(CodableColor(theme.offColor), forKey: .off)
        try container.encode(CodableColor(theme.controlColor), forKey: .ctrl)
    }
}


/**
 Settings for an arrow board
 
 These values only change when the user makes a choice in the settings view
 */
class ArrowSettings: ObservableObject {
    let defaults = UserDefaults.standard
    
    // Currently fixed
    let geometry = StandardArrowGeometry()
    
    @Published var interval: Double {
        didSet {
            defaults.set(interval, forKey: "interval")
        }
    }
    
    // MARK: Pattern

    let patterns: [ArrowPattern] = DefaultPatterns.choices

    @Published var pattern: Int {
        didSet {
            defaults.set(pattern, forKey: "pattern")
        }
    }
    
    func Pattern() -> ArrowPattern {patterns[pattern]}

    // MARK: Theme
    
    @Published var themes: [ArrowTheme] {
        didSet {
            defaults.set(
                try? PropertyListEncoder().encode(themes.compactMap { CodableArrowTheme(original: $0) }),
                forKey: "themes"
            )
        }
    }
    
    @Published var theme: Int {
        didSet {
            defaults.set(theme, forKey: "theme")
        }
    }
    
    let numberThemesFixed = DefaultThemes.choices.count
    
    func ThemeIsFixed(at: Int) -> Bool {
        return at < numberThemesFixed
    }
    
    func RemoveTheme(at: Int) {
        if at >= numberThemesFixed {
            if theme == at {
                theme = 0
            } else if theme > at {
                theme -= 1
            }
            if themes.indices.contains(at) {
                themes.remove(at: at)
            }
        }
    }
    
    func Theme() -> ArrowTheme {themes[theme]}

    init() {
        // Fetch user default values if they exist, otherwise use defaults
        interval = defaults.object(forKey: "interval") as? Double ?? 1.0
        pattern  = defaults.object(forKey: "pattern") as? Int ?? 0
        
        if let themesData = UserDefaults.standard.value(forKey: "themes") as? Data {
            //
            // Although the default scenes can't be altered, we store them anyway
            // for simplicity sake. See also the setter above.
            //
            if let mappedThemes = try? PropertyListDecoder().decode(Array<CodableArrowTheme>.self, from: themesData) {
                themes = mappedThemes.compactMap { $0.theme }
            } else {
                themes = DefaultThemes.choices
            }
        } else {
            themes = DefaultThemes.choices
        }
        theme = defaults.object(forKey: "theme") as? Int ?? 0
    }
}

