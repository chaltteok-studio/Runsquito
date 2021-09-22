//
//  Runsquito.swift
//  Runsquito
//
//  Created by jsilver on 2021/08/24.
//

import Foundation

public typealias Key = String

open class Runsquito {
    // MARK: - Property
    public static let `default` = Runsquito(description: "Default runsquito.")
    
    public private(set) var slots: [Key: AnySlot] = [:]
    public let description: String?
    
    // MARK: - Intiailzer
    public init(
        description: String? = nil,
        slots: [Key: AnySlot] = [:]
    ) {
        self.description = description
        self.slots = slots
    }
    
    // MARK: - Public
    open func addSlot<S>(_ slot: S, forKey key: Key) throws where S: Slot {
        guard slots[key] == nil else { throw RunsquitoError.keyDuplicate(key) }
        slots[key] = slot.eraseToAnySlot()
    }
    
    open func addSlot<S>(_ slot: S, forKey key: Key) throws where S: EditableSlot {
        guard slots[key] == nil else { throw RunsquitoError.keyDuplicate(key) }
        slots[key] = slot.eraseToAnySlot()
    }
    
    open func updateItem<I: Item>(_ item: I, forKey key: Key, inSlotKey slotKey: Key) throws {
        guard let slot = slots[slotKey] else { throw RunsquitoError.slotNotFound(slotKey) }
        try slot.updateItem(item.eraseToAnyItem(), forKey: key)
    }
    
    open func removeSlot(forKey key: Key) {
        slots[key] = nil
    }
    
    open func removeItem(forKey key: Key, inSlotKey slotKey: Key) {
        slots[slotKey]?.removeItem(forKey: key)
    }
    
    open func removeAllSlots() {
        slots.removeAll()
    }
    
    open func setValue<Value>(_ value: Value?, forKey key: Key) throws {
        try slots[key]?.setValue(value)
    }
    
    open func encode(forKey key: Key) throws -> Data? {
        try slots[key]?.encode()
    }
    
    open func decode(_ data: Data, forKey key: Key) throws {
        try slots[key]?.decode(from: data)
    }
    
    open func value<T>(forKey key: Key) -> T? {
        slots[key]?.value as? T
    }
    
    open func value<T>(_ type: T.Type, forKey key: Key) -> T? {
        value(forKey: key)
    }
    
    // MARK: - Private
}
