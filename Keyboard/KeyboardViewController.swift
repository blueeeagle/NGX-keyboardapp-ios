//
//  KeyboardViewController.swift
//  Keyboard
//
//  Created by Alex Appadurai on 31/03/22.
//

import UIKit

class KeyboardViewController: UIInputViewController {
    
    var socialActionView: SocialActionView!
        
    var heightLayout : NSLayoutConstraint!
    
    var profiles = StorageService.shared.socialProfile() ?? []
    
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        // Add custom view sizing constraints here
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.heightLayout = NSLayoutConstraint.init(item: self.inputView!, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1.0, constant: UIDevice.current.userInterfaceIdiom == .pad ? 380 : 270)
        
        self.heightLayout = NSLayoutConstraint.init(item: self.inputView!, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1.0, constant: 200)

        self.heightLayout.priority = .required
        view.addConstraint(heightLayout)
 
        // Perform custom UI setup here
        socialActionView = SocialActionView(frame: .init(origin: .zero, size: .init(width: view.frame.width, height: self.heightLayout.constant)))
        socialActionView.list = profiles
        socialActionView.delegate = self
        self.view.addSubview(socialActionView)
        socialActionView.addConstrainInParentHorizontal()
        socialActionView.topAnchor(value: 10)
        socialActionView.heightAnchor.constraint(equalToConstant: self.heightLayout.constant).isActive = true
       
    }

    override func textWillChange(_ textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }
    
    override func textDidChange(_ textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
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
