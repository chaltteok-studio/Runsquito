//
//  ParseableSlot.swift
//  Runsquito
//
//  Created by jsilver on 2021/08/29.
//

import Foundation

open class ParseableSlot<Value>: Slot where Value: Parseable {
    // MARK: - Prorperty
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
    
    // MARK: - Public
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
        return try Value.encode(value)
    }
    
    open func decode(_ data: Data) throws {
        value = try Value.decode(data)
    }
    
    // MARK: - Private
}
