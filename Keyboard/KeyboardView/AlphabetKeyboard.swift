//
//  AlphabetKeyboard.swift
//  Keyboard
//
//  Created by Alex Appadurai on 31/03/22.
//

import UIKit

protocol AlphabetKeyboardDelegate: KeyboardViewDelegate{
    func alphabetKeyboardDidChangeText( _ text:String)
    func alphabetKeyboardChangeBoard()
}
class AlphabetKeyboard: KeyboardView{
    enum ShiftType {
        case capitalize,upper,lower
    }
    
    @IBOutlet var alphabetButtons: Array<KeyButton>!
    
    weak var delegate: AlphabetKeyboardDelegate?
    
    var shitType = ShiftType.capitalize{
        didSet{
            updateShiftKeys()
        }
    }
    
    override var  keyboardAppearance: UIKeyboardAppearance!{
        didSet{
            super.keyboardAppearance = keyboardAppearance
            let isDarkMode = keyboardAppearance == .dark
            
            alphabetButtons.forEach { button in
                button.isDarkMode = isDarkMode
            }
        }
    }
    override var registerNib: String{
        "AlphabetKeyboard"
    }
    
    override func initialize() {
        super.initialize()
        alphabetButtons.forEach { button in
            button.addTarget(self, action: #selector(buttonTap(_:)), for: UIControl.Event.touchUpInside)
            super.addKeyButtonAction(button)
        }
        
        let tapPress = UITapGestureRecognizer.init(target: self, action: #selector(shiftButtonDoubleAction(_:)))
        tapPress.numberOfTapsRequired = 2
        shiftButton.addGestureRecognizer(tapPress)
        updateShiftKeys()
        
    }
    
    private func updateShiftKeys(){
        let caps = shitType == .capitalize || shitType == .upper
        alphabetButtons.forEach { button in
            if let primaryText = button.primaryText, let secondaryText = button.secondaryText {
                let title = caps ? primaryText : secondaryText
                button.setTitle(title, for: .normal)
            }
        }
        switch shitType {
        case .capitalize:
            shiftButton.setImage(UIImage.init(systemName: "shift.fill"), for: .normal)
        case .upper:
            shiftButton.setImage(UIImage.init(systemName: "capslock.fill"), for: .normal)
        case .lower:
            shiftButton.setImage(UIImage.init(systemName: "shift"), for: .normal)
        }
    }
    override func forceDeleteBackSpace() {
        delegate?.keyboardDidTapBackspace()
    }
    @objc func buttonTap(_ button:KeyButton){
        if  let text = button.title(for: .normal) {
            delegate?.alphabetKeyboardDidChangeText(text)
            if shitType == .capitalize {
                self.shitType = .lower
            }        }
        
    }
    @IBAction func spaceButtonAction(_ button:KeyButton){
        delegate?.keyboardDidTapSpace()
    }
    @IBAction func returnButtonAction(_ button:KeyButton){
        delegate?.keyboardDidReturn()
    }
    @IBAction func shiftButtonAction(_ button:KeyButton){
        if shitType == .lower{
            self.shitType = .capitalize
        }else{
            self.shitType = .lower
        }
        playOtherAudio()
    }
    @objc func shiftButtonDoubleAction(_ button:KeyButton){
        self.shitType = .upper
        playOtherAudio()
    }
    @IBAction func buttonBackspace(_ button:KeyButton){
        self.delegate?.keyboardDidTapBackspace()
    }
    
    @IBAction func changeBoard(_ button:KeyButton){
        self.delegate?.alphabetKeyboardChangeBoard()
    }
    
    @IBAction func changeBoardToEmojiAction(_ button:KeyButton){
        self.delegate?.keyboardDidTapEmoji()
    }
}
