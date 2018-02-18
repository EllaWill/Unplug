//
//  GraphView.swift
//  Unplug
//
//  Created by yang xu on 2/18/18.
//  Copyright © 2018 Object Coder. All rights reserved.
//

import UIKit

class GraphView: UIView {

    var statistics:[Float] = [30,60,45]
    
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        
        
        context.setStrokeColor(UIColor.black.cgColor)
        context.move(to: CGPoint(x: rect.minX, y: rect.maxY))
        context.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        context.strokePath()
        context.addEllipse(in: CGRect(x: rect.minX+50, y: 30, width: 10, height: 10))
    }
    

}
