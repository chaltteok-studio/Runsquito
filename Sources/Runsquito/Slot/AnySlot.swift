//
//  AnySlot.swift
//  Runsquito
//
//  Created by jsilver on 2021/08/31.
//

import Foundation

/// Type erased `Slot`
public struct AnySlot: Slot, Editable {
    // MARK: - Property
    private let _isEditable: () -> Bool
    public var isEditable: Bool { _isEditable() }
    
    private let _type: () -> Any.Type
    public var type: Any.Type { _type() }
    
    private let _value: () -> Any?
    public var value: Any? { _value() }
    private let _storage: () -> [Key: AnyItem]
    public var storage: [Key: AnyItem] { _storage() }
    private let _description: () -> String?
    public var description: String? { _description() }
    
    private let _add: (AnyItem, Key) throws -> Void
    private let _remove: (Key) -> Void
    private let _set: (Any?) throws -> Void
    private let _encode: () throws -> Data?
    private let _decode: (Data) throws -> Void
    
    // MARK: - Initializer
    public init<S: Slot>(_ slot: S) {
        self._isEditable = { (slot as? Editable) != nil }
        
        self._type = { S.Value.self }
        
        self._description = { slot.description }
        self._value = { slot.value }
        self._storage = { slot.storage.mapValues { AnyItem($0) } }
        
        self._add = {
            guard let value = $0.value as? S.Value else { throw RunsquitoError.typeMismatch }
            
            try slot.add(ValueItem(value, description: $0.description), for:$1)
        }
        self._remove = { slot.remove(for: $0) }
        self._set =  {
            guard $0 != nil else {
                try slot.set(nil)
                return
            }
            
            guard let value = $0 as? S.Value else { throw RunsquitoError.typeMismatch }
            
            try slot.set(value)
        }
        self._encode = {
            guard let editableSlot = slot as? Editable else { throw RunsquitoError.couldNotEdit }
            return try editableSlot.encode()
        }
        self._decode = {
            guard let editableSlot = slot as? Editable else { throw RunsquitoError.couldNotEdit }
            try editableSlot.decode($0)
        }
    }
    
    // MARK: - Public
    public func add<I: Item>(_ item: I, for key: Key) throws where I.Value == Any {
        try _add(AnyItem(item), key)
    }
    
    public func remove(for key: Key) {
        _remove(key)
    }
    
    public func set(_ value: Any?) throws {
        try _set(value)
    }
    
    public func encode() throws -> Data? {
        try _encode()
    }
    
    public func decode(_ data: Data) throws {
        try _decode(data)
    }
    
    // MARK: - Private
}
