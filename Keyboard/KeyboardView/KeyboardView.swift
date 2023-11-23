//
//  KeyboardView.swift
//  Keyboard
//
//  Created by Alex Appadurai on 03/04/22.
//

import UIKit

protocol KeyboardViewDelegate: AnyObject{
    func keyboardDidTapBackspace()
    func keyboardDidTapEmoji()
    func keyboardDidReturn()
    func keyboardDidTapSpace()
    func keyboardDidNextGlobalKeyboard()
}

class KeyboardBaseContentView : UIView{
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var globalKeyboardSwitchButton: KeyButton!
    @IBOutlet weak var backspaceButton: KeyButton!

    lazy var popup : KeyButtonPop = {
        let vw = KeyButtonPop.init()
        return vw
    }()
    
    
    //-35
    var  keyboardAppearance: UIKeyboardAppearance!{
        didSet{
            let isDarkMode = keyboardAppearance == .dark
            
            backspaceButton.isDarkMode = isDarkMode
            globalKeyboardSwitchButton.isDarkMode = isDarkMode
            
        }
    }
    var hideSwitchKey:Bool!{
        didSet{
            globalKeyboardSwitchButton.isHidden = hideSwitchKey
        }
    }
    
    var registerNib:String{
        return ""
    }
    
    var timer: Timer?

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialize()
    }
    func initialize(){
        Bundle.main.loadNibNamed(self.registerNib, owner: self, options: nil)
        addSubview(self.contentView)
        self.setNeedsLayout()
        backgroundColor = .clear
        
        self.contentView.frame = self.bounds
        self.contentView.addConstrainInParent()
        self.contentView.backgroundColor = .clear
        
        //        emojiButton.isHidden = true
        
        let longPress = UILongPressGestureRecognizer.init(target: self, action: #selector(longPressToDelete(_:)))
        longPress.minimumPressDuration = 1
        backspaceButton.addGestureRecognizer(longPress)
    }
    
    func addKeyButtonAction(_ button: KeyButton){
        button.addTarget(self, action: #selector(buttonReleaseEvent(_:)), for: UIControl.Event.touchCancel)
        button.addTarget(self, action: #selector(buttonTouched(_:)), for: UIControl.Event.touchDown)
    }
    
    
    // MARK :-
    @objc func longPressToDelete(_ gesture:UILongPressGestureRecognizer){
        
        if gesture.state == .began {
            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(handleTimer(timer:)), userInfo: nil, repeats: true)
        } else if gesture.state == .ended || gesture.state == .cancelled {
            timer?.invalidate()
            timer = nil
        }
    }
    @objc func handleTimer(timer: Timer) {
        forceDeleteBackSpace()
    }
    func forceDeleteBackSpace(){
        
    }
     
    @objc func buttonTouched(_ button:KeyButton){
        addSubview(popup)
        
        self.popup.titleLabel.text = button.title(for: .normal)
        self.popup.titleLabel.textColor = button.titleColor(for: .normal)
        self.popup.drawColor = button.backgroundColor ?? UIColor.white
        self.popup.opentMenu(button)
        
        self.popup.transform = CGAffineTransform.init(scaleX: 0.5, y: 0.5)
        UIView.animate(withDuration: 0.02) {
            self.popup.transform = CGAffineTransform.init(scaleX: 1, y: 1)
        }
        
    }
    @objc func buttonReleaseEvent(_ button:KeyButton){
        self.popup.isHidden = true
        popup.removeFromSuperview()
    }
}

class KeyboardView: KeyboardBaseContentView{
    @IBOutlet weak var spaceButton: KeyButton!
    @IBOutlet weak var returnButton: KeyButton!
    @IBOutlet weak var shiftButton: KeyButton!
    @IBOutlet weak var boardTypeButton: KeyButton!
    @IBOutlet weak var emojiButton: KeyButton!
    
    
    //-35
    override var  keyboardAppearance: UIKeyboardAppearance!{
        didSet{
            let isDarkMode = keyboardAppearance == .dark
            super.keyboardAppearance = keyboardAppearance
            shiftButton.isDarkMode = isDarkMode
            returnButton.isDarkMode = isDarkMode
            boardTypeButton.isDarkMode = isDarkMode
            spaceButton.isDarkMode = isDarkMode
            backspaceButton.isDarkMode = isDarkMode
            emojiButton.isDarkMode = isDarkMode
            
        }
    }
   
}
