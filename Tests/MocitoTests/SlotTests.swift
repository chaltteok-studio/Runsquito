//
//  SlotTest.swift
//  Mocito
//
//  Created by jsilver on 2021/08/29.
//

import XCTest
@testable import Mocito

final class SlotTests: XCTestCase {
    var slot: Slot!
    
    override func setUp() {
        slot = Slot(
            type: Bool.self,
            description: "Slot for unit test. value type is Boolean.",
            container: [:]
        )
    }
    
    func test_that_mock_is_added_into_container_when_mock_add() throws {
        // MARK: Given
        let key = "mock-key"
        let mock = Mock(value: true)
        
        // MARK: When
        try slot.add(mock, for: key)
        
        // MARK: Then
        XCTAssertNotNil(slot.container[key])
    }
    
    func test_that_mock_is_not_added_into_container_when_mock_type_does_not_match_of_slot() throws {
        // MARK: Given
        let key = "mock-key"
        let mock = Mock(value: 10)
        
        // MARK: When
        
        // MARK: Then
        XCTAssertThrowsError(try slot.add(mock, for: key))
    }
    
    func test_that_mock_is_removed_from_container_when_mock_remove() throws {
        // MARK: Given
        let key = "mock-key"
        let mock = Mock(value: true)
        
        try slot.add(mock, for: key)
        
        // MARK: When
        slot.remove(for: key)
        
        // MARK: Then
        XCTAssertNil(slot.container[key])
    }
    
    func test_that_value_is_set_when_value_set() throws {
        // MARK: Given
        let value = true
        
        // MARK: When
        try slot.set(value)
        
        // MARK: Then
        XCTAssertEqual(slot.value(Bool.self), value)
    }
    
    func test_that_value_is_set_nil_when_value_set_nil() throws {
        // MARK: Given
        let value: Bool? = nil
        try slot.set(true)
        
        // MARK: When
        try slot.set(value)
        
        // MARK: Then
        XCTAssertEqual(slot.value(Bool.self), value)
    }
    
    func test_that_value_is_not_set_when_value_type_does_not_match_of_slot() throws {
        // MARK: Given
        let value = 122
        
        // MARK: When
        
        // MARK: Then
        XCTAssertThrowsError(try slot.set(value))
    }
}
