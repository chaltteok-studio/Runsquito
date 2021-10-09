//
//  RunsquitoTests.swift
//  RunsquitoTests
//
//  Created by jsilver on 2021/08/24.
//

import XCTest
@testable import Runsquito

final class RunsquitoTests: XCTestCase {
    // MARK: - Property
    var sut: Runsquito!
    
    // MARK: - Lifecycle
    override func setUp() {
        sut = Runsquito()
    }
    
    // MARK: - Test
    func test_that_slot_is_added_when_slot_updateItem() throws {
        // MARK: Given
        let key = "runsquito-test-slot"
        let slot = ParseableSlot<Bool>()
        
        // MARK: When
        try sut.addSlot(slot, forKey: key)
        
        // MARK: Then
        XCTAssertNotNil(sut.slots[key])
    }
    
    func test_that_slot_is_not_added_when_slot_add_by_duplicated_key() throws {
        // MARK: Given
        let key = "runsquito-test-slot"
        try sut.addSlot(ParseableSlot<Bool>(), forKey: key)
        
        let slot = ParseableSlot<Int>()
        
        // MARK: When
        
        // MARK: Then
        XCTAssertThrowsError(try sut.addSlot(slot, forKey: key))
    }
    
    func test_that_item_is_added_into_storage_when_item_updateItem() throws {
        // MARK: Given
        let slotKey = "runsquito-test-slot"
        
        try sut.addSlot(ParseableSlot<Bool>(), forKey: slotKey)
        
        let key = "runsquito-test-item"
        let item = ValueItem(true)
        
        // MARK: When
        try sut.updateItem(item, forKey: key, inSlotKey: slotKey)
        
        // MARK: Then
        XCTAssertNotNil(sut.slots[slotKey]?.storage[key])
    }
    
    func test_that_item_is_not_added_into_storage_when_slot_not_found() throws {
        // MARK: Given
        let slotKey = "runsquito-test-slot"
        let key = "runsquito-test-item"
        let item = ValueItem(122)
        
        // MARK: When
        
        // MARK: Then
        XCTAssertThrowsError(try sut.updateItem(item, forKey: key, inSlotKey: slotKey))
    }
    
    func test_that_item_is_not_added_into_storage_when_item_type_dose_not_match_of_slot() throws {
        // MARK: Given
        let slotKey = "runsquito-test-slot"
        
        try sut.addSlot(ParseableSlot<Bool>(), forKey: slotKey)
        
        let key = "runsquito-test-item"
        let item = ValueItem(122)
        
        // MARK: When
        
        // MARK: Then
        XCTAssertThrowsError(try sut.updateItem(item, forKey: key, inSlotKey: slotKey))
    }
    
    func test_that_item_is_not_added_into_storage_when_item_type_dose_not_match_of_slot_by_slot() throws {
        // MARK: Given
        let slotKey = "runsquito-test-slot"
        
        try sut.addSlot(ParseableSlot<Bool>(), forKey: slotKey)
        
        let key = "runsquito-test-item"
        let item = AnyItem(ValueItem(122))
        
        // MARK: When
        
        // MARK: Then
        XCTAssertThrowsError(try sut.slots[slotKey]?.updateItem(item, forKey: key))
    }
    
    func test_that_slot_is_removed_when_slot_remove_by_key() throws {
        // MARK: Given
        let key = "runsquito-test-slot"
        try sut.addSlot(ParseableSlot<Bool>(), forKey: key)
        
        // MARK: When
        sut.removeSlot(forKey: key)
        
        // MARK: Then
        XCTAssertNil(sut.slots[key])
    }
    
    func test_that_item_is_removed_from_storage_when_item_remove_by_key() throws {
        // MARK: Given
        let slotKey = "runsquito-test-slot"
        
        try sut.addSlot(ParseableSlot<Bool>(), forKey: slotKey)
        
        let key = "runsquito-test-item"
        let item = ValueItem(true)
        
        try sut.updateItem(item, forKey: key, inSlotKey: slotKey)
        
        // MARK: When
        sut.removeItem(forKey: key, inSlotKey: slotKey)
        
        // MARK: Then
        XCTAssertNil(sut.slots[slotKey]?.storage[key])
    }
    
    func test_that_slot_is_removed_when_remove_all_slots() throws {
        // MARK: Given
        let key = "runsquito-test-slot"
        try sut.addSlot(ParseableSlot<Bool>(), forKey: key)
        
        // MARK: When
        sut.removeAllSlots()
        
        // MARK: Then
        XCTAssertNil(sut.slots[key])
    }
    
    func test_that_value_is_set_when_value_set() throws {
        // MARK: Given
        let slotKey = "runsquito-test-slot"
        let value = true
        
        try sut.addSlot(ParseableSlot<Bool>(), forKey: slotKey)
        
        // MARK: When
        try sut.setValue(value, forKey: slotKey)
        
        // MARK: Then
        XCTAssertEqual(sut.value(forKey: slotKey), value)
    }
    
    func test_that_value_is_not_set_when_value_type_does_not_match_of_slot() throws {
        // MARK: Given
        let slotKey = "runsquito-test-slot"
        
        try sut.addSlot(ParseableSlot<Bool>(), forKey: slotKey)
        
        // MARK: When
        
        // MARK: Then
        XCTAssertThrowsError(try sut.setValue(122, forKey: slotKey))
    }
    
    func test_that_value_is_not_set_when_value_type_does_not_match_of_slot_by_slot() throws {
        // MARK: Given
        let slotKey = "runsquito-test-slot"
        
        try sut.addSlot(ParseableSlot<Bool>(), forKey: slotKey)
        
        // MARK: When
        
        // MARK: Then
        XCTAssertThrowsError(try sut.slots[slotKey]?.setValue(122))
    }
    
    func test_that_value_is_not_set_when_slot_did_not_updateItem() throws {
        // MARK: Given
        let slotKey = "runsquito-test-slot"
        let value = true
        
        // MARK: When
        try sut.setValue(true, forKey: slotKey)
        
        // MARK: Then
        XCTAssertNotEqual(sut.value(Bool.self, forKey: slotKey), value)
    }
    
    func test_that_value_encoded_when_value_encode() throws {
        // MARK: Given
        let slotKey = "runsquito-test-slot"
        
        try sut.addSlot(ParseableSlot<Bool>(), forKey: slotKey)
        try sut.setValue(true, forKey: slotKey)
        
        // MARK: When
        let data = try sut.encode(forKey: slotKey)
        
        // MARK: Then
        XCTAssertNotNil(data)
    }
    
    func test_that_value_does_not_encoded_when_slot_did_not_adapt_editable() throws {
        // MARK: Given
        let slotKey = "runsquito-test-slot"
        
        try sut.addSlot(ValueSlot<Bool>(), forKey: slotKey)
        try sut.setValue(true, forKey: slotKey)
        
        // MARK: When
        
        // MARK: Then
        XCTAssertThrowsError(try sut.encode(forKey: slotKey))
    }
    
    func test_that_value_decoded_when_data_decode() throws {
        // MARK: Given
        let slotKey = "runsquito-test-slot"
        
        try sut.addSlot(ParseableSlot<Bool>(), forKey: slotKey)
        
        let data = try true.encode()
        
        // MARK: When
        try sut.decode(data, forKey: slotKey)
        
        // MARK: Then
        XCTAssertEqual(sut.value(Bool.self, forKey: slotKey), true)
    }
    
    func test_that_value_does_not_decoded_when_slot_did_not_adapt_editable() throws {
        // MARK: Given
        let slotKey = "runsquito-test-slot"
        
        try sut.addSlot(ValueSlot<Bool>(), forKey: slotKey)
        
        let data = try true.encode()
        
        // MARK: When
        
        // MARK: Then
        XCTAssertThrowsError(try sut.decode(data, forKey: slotKey))
    }
    
    // MARK: - Private
}
