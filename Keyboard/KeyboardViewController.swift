//
//  KeyboardViewController.swift
//  Keyboard
//
//  Created by Alex Appadurai on 31/03/22.
//

import UIKit

class KeyboardViewController: UIInputViewController {
    
    var alphabetKeyboard:AlphabetKeyboard!
    
    var specialKeyboard: SpecialKeyboard!
    
    var socialActionView: SocialActionView!
    
    var emojiKeyboard: EmojiKeyboard!
    
    var heightLayout : NSLayoutConstraint!
    
    var profiles = StorageService.shared.socialProfile() ?? []
    
    var keyboardContainer = KeyboardContainer.emoji{
        didSet{
            alphabetKeyboard.isHidden = true
            specialKeyboard.isHidden = true
            emojiKeyboard.isHidden = true
            
            // update
            alphabetKeyboard.keyboardAppearance = self.textDocumentProxy.keyboardAppearance
            specialKeyboard.keyboardAppearance = self.textDocumentProxy.keyboardAppearance
            emojiKeyboard.keyboardAppearance = self.textDocumentProxy.keyboardAppearance

            switch keyboardContainer {
            case .alphabet:
                alphabetKeyboard.isHidden = false
            case .special:
                specialKeyboard.isHidden = false
            case .emoji:
                emojiKeyboard.isHidden = false
            }
        }
    }
    
    enum KeyboardContainer {
        case alphabet,special,emoji
    }
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        // Add custom view sizing constraints here
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.heightLayout = NSLayoutConstraint.init(item: self.inputView!, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1.0, constant: UIDevice.current.userInterfaceIdiom == .pad ? 380 : 270)
        
        self.heightLayout.priority = .required
        view.addConstraint(heightLayout)
        
        alphabetKeyboard = AlphabetKeyboard(frame: self.view.frame)
        alphabetKeyboard.delegate = self
        alphabetKeyboard.keyboardAppearance = self.textDocumentProxy.keyboardAppearance
        
        specialKeyboard = SpecialKeyboard(frame: self.view.frame)
        specialKeyboard.delegate = self
        specialKeyboard.keyboardAppearance = self.textDocumentProxy.keyboardAppearance
        
        emojiKeyboard = EmojiKeyboard(frame: self.view.frame)
        emojiKeyboard.delegate = self

        
        // Perform custom UI setup here
        socialActionView = SocialActionView(frame: .init(origin: .zero, size: .init(width: view.frame.width, height: 50)))
        socialActionView.list = profiles
        socialActionView.delegate = self
        self.view.addSubview(socialActionView)
        socialActionView.addConstrainInParentHorizontal()
        socialActionView.heightAnchor.constraint(equalToConstant: 55).isActive = true
        self.view.addSubview(self.specialKeyboard)
        self.view.addSubview(self.alphabetKeyboard)
        self.view.addSubview(self.emojiKeyboard)

        alphabetKeyboard.addConstrainInParent(UIEdgeInsets.init(top: 55, left: 0, bottom: 0, right: 0))
        
        specialKeyboard.addConstrainInParent(UIEdgeInsets.init(top: 55, left: 0, bottom: 0, right: 0))
        
        emojiKeyboard.addConstrainInParent(UIEdgeInsets.init(top: 55, left: 0, bottom: 0, right: 0))
        
        keyboardContainer = .alphabet
        
        DispatchQueue.global(qos: .background).async {
            let list = EmojiModel.getEmojiList()
            DispatchQueue.main.async {
                self.emojiKeyboard.list = list
            }
        }
    }
    
    override func viewWillLayoutSubviews() {
        alphabetKeyboard.hideSwitchKey = !self.needsInputModeSwitchKey
        specialKeyboard.hideSwitchKey = !self.needsInputModeSwitchKey
        emojiKeyboard.hideSwitchKey = !self.needsInputModeSwitchKey
        super.viewWillLayoutSubviews()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        alphabetKeyboard.keyboardAppearance = self.textDocumentProxy.keyboardAppearance
        alphabetKeyboard.keyboardAppearance = self.textDocumentProxy.keyboardAppearance
    }
    override func textWillChange(_ textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }
    
    override func textDidChange(_ textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
    }
  
}

extension KeyboardViewController : AlphabetKeyboardDelegate, SpecialKeyboardDelegate{
    // MARK: AlphabetKeyboard
    func alphabetKeyboardDidChangeText(_ text: String) {
        self.textDocumentProxy.insertText(text)
        playTextChangeAudio()
    }
    func alphabetKeyboardChangeBoard() {
        keyboardContainer = .special
    }
    
    // MARK: SpecialKeyboard
    func specialKeyboardChangeBoard() {
        keyboardContainer = .alphabet
    }
    func specialKeyboardDidChangeText(_ text: String) {
        self.textDocumentProxy.insertText(text)
        playTextChangeAudio()
    }
    // MARK: Keyboard
    func keyboardDidReturn() {
        self.dismissKeyboard()
    }
    func keyboardDidTapSpace() {
        self.textDocumentProxy.insertText(" ")
        playTextChangeAudio()
    }
    func keyboardDidTapBackspace() {
        playBackspaceAudio()
        self.textDocumentProxy.deleteBackward()
    }
    func keyboardDidNextGlobalKeyboard() {
        self.advanceToNextInputMode()

    }
    func keyboardDidTapEmoji() {
        keyboardContainer = .emoji
    }
}


extension KeyboardViewController: SocialActionViewDelegate{
    func socialActionViewSelect(index: Int) {
        if profiles.count > index {
            //  "whatsapp://send?text=Hello%20World!"
            if StorageService.shared.launchApp(), let urlString = profiles[index].openAppURL  {
                if let url =  URL.init(string: urlString){
                    openURL(url: url as NSURL)
                }
            }else{
                self.textDocumentProxy.insertText(profiles[index].value ?? "")
            }
        }
    }
}

extension KeyboardViewController: EmojiKeyboardDelegate{
    func emojiKeyboardSelect(item: EmojiModel){
        self.textDocumentProxy.insertText(item.emoji ?? "")
    }
    func emojiKeyboardChangeBoard() {
        keyboardContainer = .alphabet
    }
}

extension KeyboardViewController{
    func openURL(url: NSURL) {
        do {
            let application = try self.sharedApplication()
            application.performSelector(inBackground: Selector("openURL:"), with: url)
        }  catch {
        }
    }
    func sharedApplication() throws -> UIApplication {
        var responder: UIResponder? = self
        while responder != nil {
            if let application = responder as? UIApplication {
                return application
            }
            responder = responder?.next
        }
        throw NSError(domain: "UIInputViewController+sharedApplication.swift", code: 1, userInfo: nil)
    }
}
