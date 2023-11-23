//
//  Button.swift
//  FontKeyboard
//
//  Created by Alex Appadurai on 01/04/22.
//  Copyright © 2017 Alex Appadurai. All rights reserved.
//

import UIKit

@IBDesignable
class SocialButton: UIButton {
    
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

    }
    
    
}
