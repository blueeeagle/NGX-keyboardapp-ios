//
//  HighlighedButton.swift
//  FontKeyboard
//
//  Created by Alex Appadurai on 12/11/17.
//  Copyright © 2017 Alex Appadurai. All rights reserved.
//

import UIKit

@IBDesignable
class HighlighedButton: KeyButton {
 
    
    override var isHighlighted: Bool{
        didSet{
            if isHighlighted {
                super.alpha = 0.75
            }else{
                super.alpha = 1
            }
        }
    }

}
