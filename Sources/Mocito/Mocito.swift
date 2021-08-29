//
//  Mocito.swift
//  Mocito
//
//  Created by jsilver on 2021/08/24.
//

import Foundation

public typealias Key = String
public typealias Value = Any

open class Mocito {
    public static let `default` = Mocito()
    
    private(set) var slots: [Key: Slot] = [:]
    
    public init() { }
    
    open func addSlot(_ slot: Slot, for key: Key) throws {
        guard slots[key] == nil else { throw MocitoError.keyDuplicate(key) }
        slots[key] = slot
    }
    
    open func addMock(_ mock: Mock, for key: Key, in slotKey: Key, description: String? = nil) throws {
        if let slot = slots[slotKey] {
            try slot.add(mock, for: key)
        } else {
            let slot = Slot(
                type: type(of: mock.value),
                description: description,
                container: [key: mock]
            )
            
            slots[slotKey] = slot
        }
    }
    
    open func removeSlot(for key: Key) {
        slots[key] = nil
    }
    
    open func removeMock(for key: Key, in slotKey: Key) {
        slots[slotKey]?.remove(for: key)
    }
    
    open func removeAll() {
        slots.removeAll()
    }
    
    open func set(value: Value?, in slotKey: Key) throws {
        try slots[slotKey]?.set(value)
    }
    
    open func value<T>(for key: Key) -> T? {
        slots[key]?.value(T.self)
    }
    
    open func value<T>(_ type: T.Type, for key: Key) -> T? {
        value(for: key)
    }
}
