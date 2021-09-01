//
//  MocitoTests.swift
//  MocitoTests
//
//  Created by jsilver on 2021/08/24.
//

import XCTest
@testable import Mocito

final class MocitoTests: XCTestCase {
    // MARK: - Property
    var sut: Mocito!
    
    // MARK: - Lifecycle
    override func setUp() {
        sut = Mocito()
    }
    
    // MARK: - Test
    func test_that_slot_is_added_when_slot_add() throws {
        // MARK: Given
        let key = "mocito-test-slot"
        let slot = ParseableSlot<Bool>()
        
        // MARK: When
        try sut.addSlot(slot, for: key)
        
        // MARK: Then
        XCTAssertNotNil(sut.slots[key])
    }
    
    func test_that_slot_is_not_added_when_slot_add_by_duplicated_key() throws {
        // MARK: Given
        let key = "mocito-test-slot"
        try sut.addSlot(ParseableSlot<Bool>(), for: key)
        
        let slot = ParseableSlot<Int>()
        
        // MARK: When
        
        // MARK: Then
        XCTAssertThrowsError(try sut.addSlot(slot, for: key))
    }
    
    func test_that_item_is_added_into_storage_when_item_add() throws {
        // MARK: Given
        let slotKey = "mocito-test-slot"
        
        try sut.addSlot(ParseableSlot<Bool>(), for: slotKey)
        
        let key = "mocito-test-item"
        let item = ValueItem(true)
        
        // MARK: When
        try sut.addItem(item, for: key, in: slotKey)
        
        // MARK: Then
        XCTAssertNotNil(sut.slots[slotKey]?.storage[key])
    }
    
    func test_that_item_is_not_added_into_storage_when_slot_not_found() throws {
        // MARK: Given
        let slotKey = "mocito-test-slot"
        let key = "mocito-test-item"
        let item = ValueItem(122)
        
        // MARK: When
        
        // MARK: Then
        XCTAssertThrowsError(try sut.addItem(item, for: key, in: slotKey))
    }
    
    func test_that_item_is_not_added_into_storage_when_item_type_dose_not_match_of_slot() throws {
        // MARK: Given
        let slotKey = "mocito-test-slot"
        
        try sut.addSlot(ParseableSlot<Bool>(), for: slotKey)
        
        let key = "mocito-test-item"
        let item = ValueItem(122)
        
        // MARK: When
        
        // MARK: Then
        XCTAssertThrowsError(try sut.addItem(item, for: key, in: slotKey))
    }
    
    func test_that_item_is_not_added_into_storage_when_item_type_dose_not_match_of_slot_by_slot() throws {
        // MARK: Given
        let slotKey = "mocito-test-slot"
        
        try sut.addSlot(ParseableSlot<Bool>(), for: slotKey)
        
        let key = "mocito-test-item"
        let item = AnyItem(ValueItem(122))
        
        // MARK: When
        
        // MARK: Then
        XCTAssertThrowsError(try sut.slots[slotKey]?.add(item, for: key))
    }
    
    func test_that_slot_is_removed_when_slot_remove_by_key() throws {
        // MARK: Given
        let key = "mocito-test-slot"
        try sut.addSlot(ParseableSlot<Bool>(), for: key)
        
        // MARK: When
        sut.removeSlot(for: key)
        
        // MARK: Then
        XCTAssertNil(sut.slots[key])
    }
    
    func test_that_item_is_removed_from_storage_when_item_remove_by_key() throws {
        // MARK: Given
        let slotKey = "mocito-test-slot"
        
        try sut.addSlot(ParseableSlot<Bool>(), for: slotKey)
        
        let key = "mocito-test-item"
        let item = ValueItem(true)
        
        try sut.addItem(item, for: key, in: slotKey)
        
        // MARK: When
        sut.removeItem(for: key, in: slotKey)
        
        // MARK: Then
        XCTAssertNil(sut.slots[slotKey]?.storage[key])
    }
    
    func test_that_slot_is_removed_when_remove_all_slots() throws {
        // MARK: Given
        let key = "mocito-test-slot"
        try sut.addSlot(ParseableSlot<Bool>(), for: key)
        
        // MARK: When
        sut.removeAll()
        
        // MARK: Then
        XCTAssertNil(sut.slots[key])
    }
    
    func test_that_value_is_set_when_value_set() throws {
        // MARK: Given
        let slotKey = "mocito-test-slot"
        let value = true
        
        try sut.addSlot(ParseableSlot<Bool>(), for: slotKey)
        
        // MARK: When
        try sut.set(value, in: slotKey)
        
        // MARK: Then
        XCTAssertEqual(sut.value(for: slotKey), value)
    }
    
    func test_that_value_is_not_set_when_value_type_does_not_match_of_slot() throws {
        // MARK: Given
        let slotKey = "mocito-test-slot"
        
        try sut.addSlot(ParseableSlot<Bool>(), for: slotKey)
        
        // MARK: When
        
        // MARK: Then
        XCTAssertThrowsError(try sut.set(122, in: slotKey))
    }
    
    func test_that_value_is_not_set_when_value_type_does_not_match_of_slot_by_slot() throws {
        // MARK: Given
        let slotKey = "mocito-test-slot"
        
        try sut.addSlot(ParseableSlot<Bool>(), for: slotKey)
        
        // MARK: When
        
        // MARK: Then
        XCTAssertThrowsError(try sut.slots[slotKey]?.set(122))
    }
    
    func test_that_value_is_not_set_when_slot_did_not_add() throws {
        // MARK: Given
        let slotKey = "mocito-test-slot"
        let value = true
        
        // MARK: When
        try sut.set(true, in: slotKey)
        
        // MARK: Then
        XCTAssertNotEqual(sut.value(Bool.self, for: slotKey), value)
    }
    
    // MARK: - Private
}
