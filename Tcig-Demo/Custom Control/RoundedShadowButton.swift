//
//  RoundedShadowButton.swift
//  Tcig-Demo
//
//  Created by Umair Afzal on 10/10/2020.
//  Copyright © 2020 Tgic Co. All rights reserved.
//

import Foundation
import UIKit

class RoundShadowButton: UIButton {

    private var shadowLayer: CAShapeLayer?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    func setup() {
        layer.cornerRadius = self.frame.width/2
        clipsToBounds = true
        layer.masksToBounds = false
        layer.shadowRadius = self.frame.width/2
        layer.shadowOpacity = 0.6
        layer.shadowOffset = CGSize(width: 0, height: 5)
        layer.shadowColor = UIColor.lightGray.cgColor
    }
}
