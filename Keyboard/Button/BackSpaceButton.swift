//
//  BackSpaceButton.swift
//  FontKeyboard
//
//  Created by Alex Appadurai on 11/11/17.
//  Copyright © 2017 Alex Appadurai. All rights reserved.
//

import UIKit

@IBDesignable
class BackSpaceButton: HighlighedButton {
    
    private  var timer: Timer?
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        let longPress = UILongPressGestureRecognizer.init(target: self, action:  #selector(longPressToDelete(_:)))
        longPress.minimumPressDuration = 1.0
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(longPress)
    }
    @objc func longPressToDelete(_ gesture:UILongPressGestureRecognizer){
        
        if gesture.state == .began {
            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(handleTimer(timer:)), userInfo: nil, repeats: true)
        } else if gesture.state == .ended || gesture.state == .cancelled {
            timer?.invalidate()
            timer = nil
        }
    }
    @objc func handleTimer(timer: Timer) {
        super.sendActions(for: .touchUpInside)
    }
}
