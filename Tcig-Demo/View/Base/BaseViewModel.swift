//
//  BaseViewModel.swift
//  Tcig-Demo
//
//  Created by Umair Afzal on 10/10/2020.
//  Copyright © 2020 Tgic Co. All rights reserved.
//

import Foundation
import UIKit

@objc protocol BaseViewModelDelegate: class {
    func showErrorAlert(message: String)
    func showSuccessAlert(message: String)
}

public class BaseViewModel {

    weak var baseDelegate: BaseViewModelDelegate?
}
