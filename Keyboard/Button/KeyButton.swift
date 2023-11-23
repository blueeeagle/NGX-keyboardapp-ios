//
//  Button.swift
//  FontKeyboard
//
//  Created by Alex Appadurai on 08/11/17.
//  Copyright © 2017 Alex Appadurai. All rights reserved.
//

import UIKit

@IBDesignable
class KeyButton: UIButton {
    
    @IBInspectable var primaryText:String?
    
    @IBInspectable var secondaryText:String?

    var  isDarkMode: Bool = false{
        didSet{
            titleLabel?.textColor = isDarkMode ? UIColor.white: UIColor.black
            setTitleColor( titleLabel?.textColor, for: .normal)
            backgroundColor = isDarkMode ? UIColor.rgb(112, 112, 112): UIColor.white
            tintColor =  titleLabel?.textColor 
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialize()
    }
    
#if !TARGET_INTERFACE_BUILDER
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize();
    }
#endif
    
    //required method to present changes in IB
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.initialize()
    }
    private  func initialize() {
        self.imageView?.contentMode = .scaleAspectFit
        self.backgroundColor = .white
        // Shadow and Radius
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        self.layer.shadowOffset =  CGSize.init(width: 0.0, height: 2.5)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 6.0
        
        configuration?.imagePadding = 5
        configuration?.imagePlacement = .all
        configuration?.titlePadding = 2
        //        self.titleLabel?.font = UIFont.init(name: "AppleSDGothicNeo-SemiBold", size: 17)
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        //        titleLabel?.backgroundColor = .red
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        super.sendActions(for: .touchCancel)
    }
    
    func hightlightFrame(_ point:CGPoint)->CGRect{
        let corner = Topspace
        let hgt = (self.frame.height * 2.0 ) + corner
        let sz = CGSize.init(width: self.frame.width * 2, height: hgt)
        let px = CGPoint.init(x: point.x - (self.frame.width/2), y: point.y - (self.frame.height + SOCIAL_HEIGHT) - corner)
        return CGRect.init(origin: px, size: sz)
        
    }
    //    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    //        super.touchesCancelled(touches, with: event)
    //    }
    
}
