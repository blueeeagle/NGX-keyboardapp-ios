//
//  AlphabetKeyboard.swift
//  Keyboard
//
//  Created by Alex Appadurai on 31/03/22.
//

import UIKit

protocol SpecialKeyboardDelegate: KeyboardViewDelegate{
    func specialKeyboardDidChangeText( _ text:String)
    func specialKeyboardChangeBoard()
}

class SpecialKeyboard: KeyboardView{
    enum ShiftType {
        case number,special
    }
    
    @IBOutlet var specialButtons: Array<KeyButton>!
    
    weak var delegate: SpecialKeyboardDelegate?
    
    var shitType = ShiftType.number{
        didSet{
            updateShiftKeys()
        }
    }
    
    override var  keyboardAppearance: UIKeyboardAppearance!{
        didSet{
            super.keyboardAppearance = keyboardAppearance
            let isDarkMode = keyboardAppearance == .dark
            specialButtons.forEach { button in
                button.isDarkMode = isDarkMode
            }
        }
    }
    override var registerNib: String{
        "SpecialKeyboard"
    }
    
    override func initialize() {
        super.initialize()
        specialButtons.forEach { button in
            button.addTarget(self, action: #selector(buttonTap(_:)), for: UIControl.Event.touchUpInside)
           super.addKeyButtonAction(button)
        }
        
        updateShiftKeys()
    }
    private func updateShiftKeys(){
        let numberboard = shitType == .number
        specialButtons.forEach { button in
            if let primaryText = button.primaryText, let secondaryText = button.secondaryText {
                let title = numberboard ? primaryText : secondaryText
                button.setTitle(title, for: .normal)
            }
        }
        switch shitType {
        case .number:
            shiftButton.titleLabel?.text = shiftButton.primaryText;
        case .special:
            shiftButton.titleLabel?.text = shiftButton.secondaryText;
            
        }
    }
    override func forceDeleteBackSpace() {
        delegate?.keyboardDidTapBackspace()
    }
    @objc func buttonTap(_ button:KeyButton){
        if  let text = button.title(for: .normal) {
            delegate?.specialKeyboardDidChangeText(text)
        }
    }
    @IBAction func spaceButtonAction(_ button:KeyButton){
        delegate?.keyboardDidTapSpace()
    }
    @IBAction func returnButtonAction(_ button:KeyButton){
        delegate?.keyboardDidReturn()
    }
    @IBAction func shiftButtonAction(_ button:KeyButton){
        if shitType == .number{
            self.shitType = .special
        }else{
            self.shitType = .number
        }
        playOtherAudio()
    }
    
    @IBAction func buttonBackspace(_ button:KeyButton){
        self.delegate?.keyboardDidTapBackspace()
    }
    
    @IBAction func changeBoard(_ button:KeyButton){
        self.delegate?.specialKeyboardChangeBoard()
    }
    
    @IBAction func changeBoardToEmojiAction(_ button:KeyButton){
        self.delegate?.keyboardDidTapEmoji()
    }
}
