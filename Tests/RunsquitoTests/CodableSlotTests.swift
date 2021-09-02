//
//  CodableSlotTests.swift
//  RunsquitoTests
//
//  Created by jsilver on 2021/08/29.
//

import XCTest
@testable import Runsquito

struct Car: Codable, Equatable {
    let name: String
    let manufacturer: String
    
    static func ==(_ lhs: Self, _ rhs: Self) -> Bool {
        lhs.name == rhs.name
    }
}

final class CodableSlotTests: XCTestCase {
    // MARK: - Property
    var slot: CodableSlot<Car>!
    
    // MARK: - Lifecycle
    override func setUp() {
        slot = .init(description: "Slot for unit test. value type is Car.")
    }
    
    // MARK: - Test
    func test_that_item_is_added_into_storage_when_item_add() {
        // MARK: Given
        let key = "test-item"
        let value = Car(
            name: "model 3",
            manufacturer: "tesla"
        )
        let item = ValueItem(value)
        
        // MARK: When
        slot.add(item, for: key)
        
        // MARK: Then
        XCTAssertNotNil(slot.storage[key])
    }
    
    func test_that_item_is_removed_from_storage_when_item_remove() {
        // MARK: Given
        let key = "test-item"
        let value = Car(
            name: "model 3",
            manufacturer: "tesla"
        )
        let item = ValueItem(value)
        
        slot.add(item, for: key)
        
        // MARK: When
        slot.remove(for: key)
        
        // MARK: Then
        XCTAssertNil(slot.storage[key])
    }
    
    func test_that_value_is_set_when_value_set() {
        // MARK: Given
        let value = Car(
            name: "model 3",
            manufacturer: "tesla"
        )
        
        // MARK: When
        slot.set(value)
        
        // MARK: Then
        XCTAssertEqual(slot.value, value)
    }
    
    func test_that_value_is_set_nil_when_value_set_nil() {
        // MARK: Given
        let value = Car(
            name: "model 3",
            manufacturer: "tesla"
        )
        slot.set(value)
        
        // MARK: When
        slot.set(nil)
        
        // MARK: Then
        XCTAssertNil(slot.value)
    }
    
    func test_that_slot_encode_value_when_encode() {
        // MARK: Given
        let value = Car(
            name: "model 3",
            manufacturer: "tesla"
        )
        
        slot.set(value)
        
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
        let value = Car(
            name: "model 3",
            manufacturer: "tesla"
        )
        let data = try encode(value)
        
        // MARK: When
        try slot.decode(data)
        
        // MARK: Then
        XCTAssertEqual(slot.value, value)
    }
    
    func test_that_slot_is_not_set_decoded_data_when_decode_fail() throws {
        // MARK: Given
        let value = 10
        let data = try Int.encode(value)
        
        // MARK: When
        
        // MARK: Then
        XCTAssertThrowsError(try slot.decode(data))
    }
    
    // MARK: - Private
    private func encode<T: Encodable>(_ value: T) throws -> Data {
        let encoder = JSONEncoder()
        return try encoder.encode(value)
    }
}
