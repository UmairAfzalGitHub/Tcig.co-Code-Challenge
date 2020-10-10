//
//  AirportService.swift
//  Tcig-Demo
//
//  Created by Umair Afzal on 10/10/2020.
//  Copyright © 2020 Tgic Co. All rights reserved.
//

import Foundation

class AirportService {

    /// A function that gets static data from Airports.plist file
    /// - Parameter completion: callback on success/failure
    func getAirports(completion: (Bool, [AirportLocation]) -> Void) {
        // AirportLocationModel.plist file contains 10 elements of AirportLocation
        guard let path = Bundle.main.url(forResource: "Airports", withExtension: "plist") else {
            completion(false, [])
            return
        }

        do {
            let decoder = PropertyListDecoder()
            guard let data = try? Data(contentsOf: path) else {
                completion(false, [])
                return
            }

            let airports = try decoder.decode([AirportLocation].self, from: data)
            completion(true, airports)

        } catch {
            print(error.localizedDescription)
            completion(false, [])
        }
    }
}
