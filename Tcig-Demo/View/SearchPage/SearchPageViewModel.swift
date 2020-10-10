//
//  SearchPageViewModel.swift
//  Tcig-Demo
//
//  Created by Umair Afzal on 10/10/2020.
//  Copyright © 2020 Tgic Co. All rights reserved.
//

import Foundation

class SearchPageViewModel: BaseViewModel {

    var airports = [AirportLocation]()
    let travelClasses = ["First Class", "Business Class", "Economy Class"]

    func getAirports() {

        AirportService().getAirports { (success, airports) in

            if success {
                self.airports = airports
                
            } else {
                self.baseDelegate?.showErrorAlert(message: "Could not load data.")
            }
        }
    }
}
