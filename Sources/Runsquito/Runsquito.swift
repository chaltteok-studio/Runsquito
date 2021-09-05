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
    open func addSlot<S: Slot>(_ slot: S, for key: Key) throws {
        guard slots[key] == nil else { throw RunsquitoError.keyDuplicate(key) }
        slots[key] = AnySlot(slot)
    }
    
    open func addItem<I: Item>(_ item: I, for key: Key, in slotKey: Key) throws {
        guard let slot = slots[slotKey] else { throw RunsquitoError.slotNotFound(slotKey) }
        try slot.add(AnyItem(item), for: key)
    }
    
    open func removeSlot(for key: Key) {
        slots[key] = nil
    }
    
    open func removeItem(for key: Key, in slotKey: Key) {
        slots[slotKey]?.remove(for: key)
    }
    
    open func removeAll() {
        slots.removeAll()
    }
    
    open func set<Value>(_ value: Value?, in slotKey: Key) throws {
        try slots[slotKey]?.set(value)
    }
    
    open func encode(for key: Key) throws -> Data? {
        try slots[key]?.encode()
    }
    
    open func decode(_ data: Data, for key: Key) throws {
        try slots[key]?.decode(data)
    }
    
    open func value<T>(for key: Key) -> T? {
        slots[key]?.value as? T
    }
    
    open func value<T>(_ type: T.Type, for key: Key) -> T? {
        value(for: key)
    }
    
    // MARK: - Private
}
