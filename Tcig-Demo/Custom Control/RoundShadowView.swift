//
//  ShadowView.swift
//  Tcig-Demo
//
//  Created by Umair Afzal on 10/10/2020.
//  Copyright © 2020 Tgic Co. All rights reserved.
//

import Foundation
import UIKit

class RoundShadowView: UIView {

    private var shadowLayer: CAShapeLayer?
    private var cornerRadiusValue: CGFloat = 16.0

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    func setup() {
        layer.cornerRadius = cornerRadiusValue
        clipsToBounds = true
        layer.masksToBounds = false
        layer.shadowRadius = cornerRadiusValue
        layer.shadowOpacity = 0.6
        layer.shadowOffset = CGSize(width: 0, height: 5)
        layer.shadowColor = UIColor.lightGray.cgColor
    }
}
