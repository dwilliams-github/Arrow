//
//  ArrowGeometry.swift
//  Arrow
//
//  Created by David Williams on 12/2/20.
//  Copyright © 2020 David Williams. All rights reserved.
//

import SwiftUI

/**
 ArrowGeometry
 
 Specifies the number and placement of bulbs.
 */
protocol ArrowGeometry {
    var number: Int {get}
    func BulbDiameter(enclosureSize: CGSize) ->CGFloat
    func Position(bulb: Int, enclosureSize: CGSize) -> CGPoint
}

/**
 StandardArrowGeometry
 
 Perhaps in a future version we could have different geometries?
 */
class StandardArrowGeometry : ArrowGeometry {
    var number: Int = 25
    
    func BulbDiameter(enclosureSize: CGSize) -> CGFloat {
        return 0.10*enclosureSize.height
    }
    
    func Position(bulb: Int, enclosureSize: CGSize) -> CGPoint {
        let marg: CGFloat = 0.095*enclosureSize.height
        let xspace: CGFloat = enclosureSize.width - 2*marg
        let yspace: CGFloat = enclosureSize.height - 2*marg
        let dx: CGFloat = xspace/6
        let dy: CGFloat = yspace/4
        
        if (bulb < 3) {
            return CGPoint(x: marg+(2.0*CGFloat(bulb)+1)*dx,     y: marg     )
        } else if (bulb < 9) {
            return CGPoint(x: marg+(1.0*CGFloat(bulb-3)+0.5)*dx, y: marg+dy  )
        } else if (bulb < 16) {
            return CGPoint(x: marg+CGFloat(bulb-9)*dx,           y: marg+2*dy)
        } else if (bulb < 22) {
            return CGPoint(x: marg+(CGFloat(bulb-16)+0.5)*dx,    y: marg+3*dy)
        } else {
            return CGPoint(x: marg+(2*CGFloat(bulb-22)+1)*dx,    y: marg+4*dy)
        }
    }
}
