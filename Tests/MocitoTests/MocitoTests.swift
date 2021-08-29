//
//  MocitoTests.swift
//  Mocito
//
//  Created by jsilver on 2021/08/24.
//

import XCTest
@testable import Mocito

final class MocitoMockTests: XCTestCase {
    var sut: Mocito!
    
    override func setUp() {
        sut = Mocito()
    }
    
    func test_that_slot_is_added_when_slot_add() throws {
        // MARK: Given
        let key = "mocito-test-slot"
        let slot = Slot(type: Bool.self)
        
        // MARK: When
        try sut.addSlot(slot, for: key)
        
        // MARK: Then
        XCTAssertNotNil(sut.slots[key])
    }
    
    func test_that_slot_is_not_added_when_slot_add_by_duplicated_key() throws {
        // MARK: Given
        let key = "mocito-test-slot"
        try sut.addSlot(Slot(type: Bool.self), for: key)
        
        let slot = Slot(type: Int.self)
        
        // MARK: When
        
        // MARK: Then
        XCTAssertThrowsError(try sut.addSlot(slot, for: key))
    }
    
    func test_that_slot_is_added_when_mock_add() throws {
        // MARK: Given
        let slotKey = "mocito-test-slot"
        
        let mock = Mock(value: true)
        let key = "mocito-test-mock"
        
        // MARK: When
        try sut.addMock(mock, for: key, in: slotKey)
        
        // MARK: Then
        XCTAssertNotNil(sut.slots[slotKey])
    }
    
    func test_that_slot_is_removed_when_slot_remove_by_key() throws {
        // MARK: Given
        let key = "mocito-test-slot"
        try sut.addSlot(Slot(type: Bool.self), for: key)
        
        // MARK: When
        sut.removeSlot(for: key)
        
        // MARK: Then
        XCTAssertNil(sut.slots[key])
    }
    
    func test_that_slot_is_removed_when_remove_all_slots() throws {
        // MARK: Given
        let key = "mocito-test-slot"
        try sut.addSlot(Slot(type: Bool.self), for: key)
        
        // MARK: When
        sut.removeAll()
        
        // MARK: Then
        XCTAssertNil(sut.slots[key])
    }
    
    func test_that_mock_is_added_into_container_when_mock_add() throws {
        // MARK: Given
        let slotKey = "mocito-test-slot"
        
        try sut.addSlot(Slot(type: Bool.self), for: slotKey)
        
        let key = "mocito-test-mock"
        let mock = Mock(value: true)
        
        // MARK: When
        try sut.addMock(mock, for: key, in: slotKey)
        
        // MARK: Then
        XCTAssertNotNil(sut.slots[slotKey]?.container[key])
    }
    
    func test_that_mock_is_not_added_into_container_when_mock_type_dose_not_match_of_slot() throws {
        // MARK: Given
        let slotKey = "mocito-test-slot"
        
        try sut.addSlot(Slot(type: Bool.self), for: slotKey)
        
        let key = "mocito-test-mock"
        let mock = Mock(value: 122)
        
        // MARK: When
        
        // MARK: Then
        XCTAssertThrowsError(try sut.addMock(mock, for: key, in: slotKey))
    }
    
    func test_that_mock_is_not_added_into_container_when_mock_type_dose_not_match_of_slot_by_slot() throws {
        // MARK: Given
        let slotKey = "mocito-test-slot"
        
        try sut.addSlot(Slot(type: Bool.self), for: slotKey)
        
        let key = "mocito-test-mock"
        let mock = Mock(value: 122)
        
        // MARK: When
        
        // MARK: Then
        XCTAssertThrowsError(try sut.slots[slotKey]?.add(mock, for: key))
    }
    
    func test_that_mock_is_removed_from_container_when_mock_remove_by_key() throws {
        // MARK: Given
        let slotKey = "mocito-test-slot"
        
        try sut.addSlot(Slot(type: Bool.self), for: slotKey)
        
        let key = "mocito-test-mock"
        let mock = Mock(value: true)
        
        try sut.addMock(mock, for: key, in: slotKey)
        
        // MARK: When
        sut.removeMock(for: key, in: slotKey)
        
        // MARK: Then
        XCTAssertNil(sut.slots[slotKey]?.container[key])
    }
    
    func test_that_value_is_set_when_value_set() throws {
        // MARK: Given
        let slotKey = "mocito-test-slot"
        let value = true
        
        try sut.addSlot(Slot(type: Bool.self), for: slotKey)
        
        // MARK: When
        try sut.set(value: value, in: slotKey)
        
        // MARK: Then
        XCTAssertEqual(sut.value(for: slotKey), value)
    }
    
    func test_that_value_is_not_set_when_value_type_does_not_match_of_slot() throws {
        // MARK: Given
        let slotKey = "mocito-test-slot"
        
        try sut.addSlot(Slot(type: Bool.self), for: slotKey)
        
        // MARK: When
        
        // MARK: Then
        XCTAssertThrowsError(try sut.set(value: 122, in: slotKey))
    }
    
    func test_that_value_is_not_set_when_slot_did_not_add() throws {
        // MARK: Given
        let slotKey = "mocito-test-slot"
        let value = true
        
        // MARK: When
        try sut.set(value: true, in: slotKey)
        
        // MARK: Then
        XCTAssertNotEqual(sut.value(Bool.self, for: slotKey), value)
    }
}
