//
//  CodableSlot.swift
//  Mocito
//
//  Created by jsilver on 2021/08/31.
//

import Foundation

open class CodableSlot<Value>: Slot where Value: Codable {
    // MARK: - Property
    public private(set) var value: Value?
    public private(set) var storage: [Key: AnyItem]
    public let description: String?
    
    // MARK: - Initializer
    public init(
        value: Value? = nil,
        description: String? = nil,
        storage: [Key: AnyItem] = [:]
    ) {
        self.value = value
        self.description = description
        self.storage = storage
    }
    
    // MARK: - Publlic
    open func add<I: Item>(_ item: I, for key: Key) where I.Value == Value {
        storage[key] = AnyItem(item)
    }
    
    open func remove(for key: Key) {
        storage[key] = nil
    }
    
    open func set(_ value: Value?) {
        self.value = value
    }
    
    open func encode() throws -> Data? {
        guard let value = value else { return nil }
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        return try encoder.encode(value)
    }
    
    open func decode(_ data: Data) throws {
        let decoder = JSONDecoder()
        value = try decoder.decode(Value.self, from: data)
    }
    
    // MARK: - Private
}
