//
//  ButtonMenuView.swift
//  FontKeyboard
//
//  Created by Alex Appadurai on 12/11/17.
//  Copyright © 2017 Alex Appadurai. All rights reserved.
//

import UIKit
let Topspace : CGFloat = 12.0
let SOCIAL_HEIGHT:CGFloat = 50

class KeyButtonPop: UIView {
    
    
    var drawColor = UIColor.white{
        didSet{
            setNeedsDisplay()
        }
    }
    private var isDrawing = false
    
    var titleLabel : UILabel!
    
    //MARK:- init
    init() {
        super.init(frame: CGRect.zero)
        self.titleLabel = UILabel.init(frame: CGRect.zero)
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: 32)
        self.titleLabel.textAlignment = .center
        self.addSubview(self.titleLabel)
        self.backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        super.draw(rect)
        
        // Drawing code
        
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
         context.setStrokeColor(UIColor.lightGray.cgColor)
        context.setFillColor(drawColor.cgColor)
        context.setLineWidth(0.65)
        
        let y  : CGFloat = 5
        let x  : CGFloat = 5
        let curve  : CGFloat = 10
        
        let width = rect.width - x/2 * 2
        let height = rect.height + y
        
        let minX = (rect.width * 0.25)
        let maxX = (rect.width * 0.75)
        
        let maxY = (rect.height/2 + 10)
        let minY = (rect.height/2 - 5)
        /*
         .
         */
        context.move(to: CGPoint.init(x: x+curve, y: y))
        /// ->
        context.addLine(to: CGPoint.init(x: width-curve,    y: y))
        context.addQuadCurve(to: CGPoint.init(x: width, y: y+curve), control: CGPoint.init(x: width,    y: y))
        
        // right c
        context.addLine(to: CGPoint.init(x: width,    y: minY))
        context.addLine(to: CGPoint.init(x: maxX,     y: maxY))
        
        context.addLine(to: CGPoint.init(x: maxX,     y: height))
        context.addLine(to: CGPoint.init(x: minX,     y: height))
        
        context.addLine(to: CGPoint.init(x: minX,     y:  maxY))
        context.addLine(to: CGPoint.init(x: x,        y: minY))
        context.addLine(to: CGPoint.init(x: x, y: y+curve))
        context.addQuadCurve(to: CGPoint.init(x: x+curve, y: y), control: CGPoint.init(x: x,    y: y))
        
        context.drawPath(using: .fillStroke)
        
    }
    
    func opentMenu(_ button:KeyButton){
        self.isHidden = false
        let point = button.convert(CGPoint.zero, to: nil)
        let corner = Topspace
        let hgt = (button.frame.height * 2.0 ) + corner
        let sz = CGSize.init(width: button.frame.width * 2, height: hgt)
        let px = CGPoint.init(x: point.x - (button.frame.width/2), y: point.y - (button.frame.height + SOCIAL_HEIGHT) - corner)
        
        let frame = CGRect.init(origin: px, size: sz)
//        if button.key.topKey {
//            frame.origin.y = 0
//            frame.size.height = button.frame.height + Topspace
//        }
        self.frame = frame
        
        
        if self.isDrawing == false {
            self.isDrawing = true
            self.setNeedsDisplay()
        }
        //        let x = self.frame.width/2 - 8
        let y = self.frame.height * 0.1
        self.titleLabel.frame = CGRect.init(x: 0, y: y, width: self.frame.width, height: 40)
    }
   
}


extension CGContext{
    func setShadow(){
        self.setShadow(offset: CGSize.init(width: 2, height: 2), blur: 0.5, color: UIColor.red.cgColor)
    }
}
fileprivate extension CGFloat{
    var half:CGFloat{
        return self/2.0
    }
}
