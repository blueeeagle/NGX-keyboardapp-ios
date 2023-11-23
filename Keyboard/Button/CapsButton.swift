//
//  CapsButton.swift
//  FontKeyboard
//
//  Created by Alex Appadurai on 11/11/17.
//  Copyright © 2017 Alex Appadurai. All rights reserved.
//

import UIKit

enum AlphaMode {
    case lower
    case caps
    case number
    case special
    var isAlphabet : Bool{
        return self == .lower || self == .caps
    }
}

class CapsButton: KeyButton {
    
    var mode = AlphaMode.caps{
        didSet{
            mackup()
        }
    }
    
    var normalBackgroundColor : UIColor!{
        didSet{
            self.backgroundColor = normalBackgroundColor
        }
    }
    
    override var isSelected: Bool{
        didSet{
            if isSelected {
                self.backgroundColor = UIColor.white
            }else{
                self.backgroundColor = self.normalBackgroundColor
            }
        }
    }
   
    
    func mackup(){
        self.isSelected = false
        if self.mode == .caps {
            self.setTitle("⇪", for: UIControl.State.normal)
            self.isSelected = true
        }else if self.mode == .lower {
            self.setTitle("⇧", for: UIControl.State.normal)
        }else if self.mode == .special {
            self.setTitle("123", for: UIControl.State.normal)
        }else{
            self.setTitle("#+=", for: UIControl.State.normal)
        }
    }
}
