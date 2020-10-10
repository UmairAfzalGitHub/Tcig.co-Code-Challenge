//
//  UITextfField.swift
//  Tgic-Demo
//
//  Created by Umair Afzal on 09/10/2020.
//  Copyright © 2020 Tgic Co. All rights reserved.
//

import UIKit

extension UITextField{
    
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
}

