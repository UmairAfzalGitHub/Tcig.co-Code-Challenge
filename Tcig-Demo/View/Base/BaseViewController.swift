//
//  BaseViewController.swift
//  Tcig-Demo
//
//  Created by Umair Afzal on 10/10/2020.
//  Copyright © 2020 Tgic Co. All rights reserved.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension BaseViewController: BaseViewModelDelegate {

    func showErrorAlert(message: String) {
        AlertBuilder.failureAlertWithMessage(message: message)
    }

    func showSuccessAlert(message: String) {
        AlertBuilder.successAlertWithMessage(message: message)
    }
}
