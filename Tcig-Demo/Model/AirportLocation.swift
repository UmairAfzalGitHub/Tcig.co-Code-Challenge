//
//  AirportLocation.swift
//  Tgic-Demo
//
//  Created by Umair Afzal on 09/10/2020.
//  Copyright © 2020 Tgic Co. All rights reserved.
//

import Foundation

struct AirportLocation: Decodable, Equatable {
   
    let id: String
    let name: String
    let city: String
    let code: String
    
    /*
     - This init method is to validate unit test for our Photo Property
     */
    
    init(id: String, name: String, city: String, code: String) {
        self.id = id
        self.name = name
        self.city = city
        self.code = code
    }
    
    // MARK: - Equatable Protocol
    
    static func == (lhs: AirportLocation, rhs: AirportLocation) -> Bool {
        
        if lhs.id == rhs.id {
            return true
        }
        
        return false
    }
}
