//
//  UIView.swift
//  Tgic-Demo
//
//  Created by Umair Afzal on 09/10/2020.
//  Copyright © 2020 Tgic Co. All rights reserved.
//

import UIKit

extension UIView {

    @IBInspectable
    var isCirculer: Bool {

        get {
            return layer.cornerRadius == min(self.frame.width, self.frame.height) / CGFloat(2.0) ? true : false
        }
        set {
            if newValue {
                layer.cornerRadius = self.frame.height/2
                self.clipsToBounds = true
            } else {
                layer.cornerRadius = 0.0
                self.clipsToBounds = false
            }
        }
    }

    @IBInspectable
    var cornerRadius: CGFloat {

        get {
            return layer.cornerRadius
        }

        set {
            layer.cornerRadius = newValue
        }
    }

    /// A function that applies
    /// - Parameters:
    ///   - colors: Array of colors for gradient
    ///   - locations: Array of locations for gradient
    ///   - direction: Start to end direction for gardient
    ///   - isFullFrame: Indicates the frame of gradient
    ///   - isCircular: Pass true if your view is circular
    ///   - cornerRadius: Value for the corner radius
    func applyGradient(colors: [Any]?, locations: [NSNumber]? = [0.0, 1.0], direction: Direction = .topToBottom, isFullFrame: Bool = false, isCircular: Bool = false, cornerRadius: CGFloat = 16.0) {

        let gradientLayer = CAGradientLayer()
        if isFullFrame {
            gradientLayer.frame = self.bounds
        } else {
            gradientLayer.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: self.frame.width, height: self.frame.height/2)
        }
        gradientLayer.colors = colors
        gradientLayer.locations = locations

        switch direction {
        case .topToBottom:
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)

        case .bottomToTop:
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)

        case .leftToRight:
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)

        case .rightToLeft:
            gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.5)
        }

        if isCircular {
            gradientLayer.cornerRadius = cornerRadius
            clipsToBounds = true
            layer.masksToBounds = false
            gradientLayer.shadowRadius = cornerRadius
        }

        self.layer.insertSublayer(gradientLayer, at: 0)

    }

    /// A function that rounds the top or bottom corners of given view
    /// - Parameters:
    ///   - top: Rounds the top corners if true, else rounds the bottom corners
    ///   - cornerRadius: Value of corner radius
    func roundedCorners(corners: UIRectCorner, cornerRadius: Int = 16){
        let maskPAth = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii:CGSize(width:16.0, height:16.0))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPAth.cgPath
        self.layer.mask = maskLayer
    }
}
