//
//  MenuAppearance.swift
//  DemoTutorial
//
//  Created by can.khac.nguyen on 10/8/18.
//  Copyright © 2018 can.khac.nguyen. All rights reserved.
//

import Foundation
import UIKit

class MenuAppearance: UIPopoverBackgroundView {
    override class func arrowBase() -> CGFloat { return 0 }
    override class func arrowHeight() -> CGFloat { return 20 }
    
    override class func contentViewInsets() -> UIEdgeInsets {
        return UIEdgeInsets(top: 0,left: 0,bottom: 0,right: 0)
    }
    
    // inherits:
    // @property (nonatomic, readwrite) UIPopoverArrowDirection arrowDirection
    // @property (nonatomic, readwrite) CGFloat arrowOffset
    // we are required to reimplement these, even trivially
    // for some reason it is not enough to call super! very weird
    var arrOff : CGFloat
    var arrDir : UIPopoverArrowDirection
    override var arrowDirection : UIPopoverArrowDirection {
        get { return self.arrDir }
        set { self.arrDir = newValue }
    }
    override var arrowOffset : CGFloat {
        get { return self.arrOff }
        set { self.arrOff = newValue }
    }
    
    override init(frame:CGRect) {
        self.arrOff = 0
        self.arrDir = .any
        super.init(frame:frame)
        self.isOpaque = false
    }
    
    required init(coder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    override class var wantsDefaultContentAppearance : Bool {
        return true // try false to see if you can find a difference...
    }
    
    
    override func draw(_ rect: CGRect) {
        // WARNING: this code is sort of a cheat:
        // I should be checking self.arrowDirection and changing what I do depending on that...
        // but instead I am just *assuming* that the arrowDirection is UIPopoverArrowDirectionUp
        
//        let linOrig = UIImage(named: "linen.png")!
//        let capw = linOrig.size.width / 2.0 - 1
//        let caph = linOrig.size.height / 2.0 - 1
//        let lin = linOrig.resizableImage(
//            withCapInsets:UIEdgeInsets(top: caph, left: capw, bottom: caph, right: capw),
//            resizingMode:.tile)
        
        let klass = type(of:self)
        let arrowHeight = klass.arrowHeight()
        let arrowBase = klass.arrowBase()
        
        // draw the arrow
        // I'm just going to make a triangle filled with our linen background...
        // ...extended by a rectangle so it joins to our "pinked" corner drawing
        
        var arrow : Bool {return false} // false to omit arrow, cute technique
        if arrow {
            
            let con = UIGraphicsGetCurrentContext()!
            con.saveGState()
            // clamp offset
            var propX = self.arrowOffset
            let limit : CGFloat = 22.0
            let maxX = rect.size.width/2.0 - limit
            propX = min(max(propX, limit), maxX)
            // draw!
            con.translateBy(x: rect.size.width/2.0 + propX - arrowBase/2.0, y: 0)
            con.move(to: CGPoint(x: 0, y: arrowHeight))
            con.addLine(to: CGPoint(x: arrowBase / 2.0, y: 0))
            con.closePath()
            con.addRect(CGRect(x: 0, y: arrowHeight, width: arrowBase, height: 15))
            con.clip()
//            lin.draw(at: CGPoint(x: -40, y: -40))
            con.restoreGState()
            
        }
        
        // draw the body, to go behind the view part of our rectangle (i.e. rect minus arrow)
        let (_,body) = rect.divided(atDistance: arrowHeight, from: .minYEdge)
//        lin.draw(in:body)
        
    }
}
