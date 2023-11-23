//
//  UIView+Constrains.swift
//  Keyboard
//
//  Created by Alex Appadurai on 31/03/22.
//

import UIKit

extension UIView{
    
    func addConstrainInParent(_ padding: UIEdgeInsets = UIEdgeInsets.zero){
        guard let parent = self.superview else {
            return
        }
        self.translatesAutoresizingMaskIntoConstraints = false
        leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: padding.left).isActive = true
        trailingAnchor.constraint(equalTo: parent.trailingAnchor, constant: padding.right).isActive = true
        topAnchor.constraint(equalTo: parent.topAnchor, constant: padding.top).isActive = true
        bottomAnchor.constraint(equalTo: parent.bottomAnchor, constant: padding.bottom).isActive = true
        
    }
    func addConstrainInParentHorizontal(_ left: CGFloat = 0,_ right: CGFloat = 0){
        guard let parent = self.superview else {
            return
        }
        self.translatesAutoresizingMaskIntoConstraints = false
        leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: left).isActive = true
        trailingAnchor.constraint(equalTo: parent.trailingAnchor, constant: right).isActive = true
 
    }
}
