//
//  AnySlotTests.swift
//  RunsquitoTests
//
//  Created by jsilver on 2021/09/01.
//

import XCTest
@testable import Runsquito

final class AnySlotTests: XCTestCase {
    // MARK: - Property
    var slot: AnySlot!
    
    // MARK: - Lifecycle
    override func setUp() {
        slot = .init(editable: ParseableSlot<Bool>(description: "Slot for unit test. value type is Boolean."))
    }
    
    // MARK: - Test
    func test_that_item_is_added_into_storage_when_item_updateItem() throws {
        // MARK: Given
        let key = "test-item"
        let item: ValueItem<Any> = ValueItem(true)
        
        // MARK: When
        try slot.updateItem(item, forKey: key)
        
        // MARK: Then
        XCTAssertNotNil(slot.storage[key])
    }
    
    func test_that_item_is_not_added_into_storage_when_item_type_dose_not_match_of_slot() throws {
        // MARK: Given
        let key = "test-item"
        let item: ValueItem<Any> = ValueItem(122)
        
        // MARK: When
        
        // MARK: Then
        XCTAssertThrowsError(try slot.updateItem(item, forKey: key))
    }
    
    func test_that_item_is_removed_from_storage_when_item_remove() throws {
        // MARK: Given
        let key = "test-item"
        let item: ValueItem<Any> = ValueItem(true)
        
        try slot.updateItem(item, forKey: key)
        
        // MARK: When
        slot.removeItem(forKey: key)
        
        // MARK: Then
        XCTAssertNil(slot.storage[key])
    }
    
    func test_that_value_is_set_when_value_set() throws {
        // MARK: Given
        let value = true
        
        // MARK: When
        try slot.setValue(value)
        
        // MARK: Then
        XCTAssertEqual(slot.value as? Bool, value)
    }
    
    func test_that_value_is_not_set_when_value_type_does_not_match_of_slot() throws {
        // MARK: Given
        let value = 122
        
        // MARK: When
        
        // MARK: Then
        XCTAssertThrowsError(try slot.setValue(value))
    }
    
    func test_that_value_is_set_nil_when_value_set_nil() throws {
        // MARK: Given
        let value = true
        try slot.setValue(value)
        
        // MARK: When
        try slot.setValue(nil)
        
        // MARK: Then
        XCTAssertNil(slot.value)
    }
    
    func test_that_slot_encode_value_when_encode() throws {
        // MARK: Given
        let value = true
        
        try slot.setValue(value)
        
        // MARK: When
        let encodedData = try? slot.encode()
        
        // MARK: Then
        XCTAssertNotNil(encodedData)
    }
    
    func test_that_slot_encode_value_when_value_is_nil() throws {
        // MARK: Given
        
        // MARK: When
        let encodedData = try slot.encode()
        
        // MARK: Then
        XCTAssertNil(encodedData)
    }
    
    func test_that_slot_is_set_decoded_data_when_decode() throws {
        // MARK: Given
        let value = true
        let data = try value.encode()
        
        // MARK: When
        try slot.decode(from: data)
        
        // MARK: Then
        XCTAssertEqual(slot.value as? Bool, value)
    }
    
    func test_that_slot_is_not_set_decoded_data_when_decode_fail() throws {
        // MARK: Given
        let value = 10
        let data = try value.encode()
        
        // MARK: When
        
        // MARK: Then
        XCTAssertThrowsError(try slot.decode(from: data))
    }
    
    // MARK: - Private
}
