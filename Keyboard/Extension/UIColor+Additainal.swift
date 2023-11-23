//
//  UIColor+Additainal.swift
//  Keyboard
//
//  Created by Alex Appadurai on 01/04/22.
//

import UIKit

extension UIColor{
    static func rgb(_ r:CGFloat,_ g: CGFloat,_ b:CGFloat,_ a: CGFloat=1) ->UIColor{
        return   UIColor.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
    }
}
