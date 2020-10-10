//
//  AirportLocationModel.swift
//  Tgic-DemoTests
//
//  Created by Umair Afzal on 09/10/2020.
//  Copyright © 2020 Tgic Co. All rights reserved.
//

import XCTest
@testable import Tcig_Demo

class AirportLocationModel: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    // MARK: - Initialization Tests
    
    func testAirportLocationModel_ForInit_ReturnsSuccess() {
        
        // Arrange
        let id = "5000897643221"
        let name = "Heathrow Airport"
        let city = "London, UK"
        let code = "1234"
        
        // Act
        let sut = AirportLocation(id: id, name: name, city: city, code: code) // sut: System Under Test
        
        // Assert
        XCTAssertNotNil(sut)
        XCTAssertEqual(sut.id, "5000897643221")
        XCTAssertEqual(sut.name, "Heathrow Airport")
        XCTAssertEqual(sut.city, "London, UK")
        XCTAssertEqual(sut.code, "1234")
    }
    
    // MARK: - Equatable Tests
    
    func testPhotoModel_ForEquatable_ReturnsSuccess() {
        
        // Arrange
        let id = "5000897643221"
        let name = "Heathrow Airport"
        let city = "London, UK"
        let code = "1234"
        
        // Act
        let airport1 = AirportLocation(id: id, name: name, city: city, code: code)
        let airport2 = AirportLocation(id: id, name: name, city: city, code: code)
        
        // Assert
        XCTAssertEqual(airport1, airport2)
    }
}
