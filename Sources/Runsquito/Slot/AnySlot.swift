//
//  AnySlot.swift
//  Runsquito
//
//  Created by jsilver on 2021/08/31.
//

import Foundation

/// Type erased `Slot`
public class AnySlot: EditableSlot {
    // MARK: - Property
    public let type: Any.Type
    public let isEditable: Bool
    
    private let _value: () -> Any?
    public var value: Any? { _value() }
    
    private let _storage: () -> [Key: AnyItem]
    public var storage: [Key: AnyItem] { _storage() }
    
    private let _description: () -> String?
    public var description: String? { _description() }
    
    private let _updateItem: (AnyItem, Key) throws -> Void
    private let _removeItem: (Key) -> Void
    private let _setValue: (Any?) throws -> Void
    private let _encode: () throws -> Data?
    private let _decode: (Data) throws -> Void
    
    // MARK: - Initializer
    public init<S>(
        _ slot: S,
        isEditable: Bool = false,
        encode: @escaping () throws -> Data? = { throw RunsquitoError.couldNotEdit },
        decode: @escaping (Data) throws -> Void = { _ in throw RunsquitoError.couldNotEdit }
    ) where S: Slot {
        type = S.Value.self
        self.isEditable = isEditable
        
        self._description = { slot.description }
        self._value = { slot.value }
        self._storage = { slot.storage.mapValues { AnyItem($0) } }
        
        self._updateItem = {
            guard let value = $0.value as? S.Value else { throw RunsquitoError.typeMismatch }
            
            try slot.updateItem(ValueItem(value, description: $0.description), forKey: $1)
        }
        self._removeItem = { slot.removeItem(forKey: $0) }
        self._setValue =  {
            guard $0 != nil else {
                try slot.setValue(nil)
                return
            }
            
            guard let value = $0 as? S.Value else { throw RunsquitoError.typeMismatch }
            
            try slot.setValue(value)
        }
        self._encode = encode
        self._decode = decode
    }
    
    public convenience init<S>(editable slot: S) where S: EditableSlot {
        self.init(
            slot,
            isEditable: true
        ) {
            try slot.encode()
        } decode: {
            try slot.decode(from: $0)
        }
    }
    
    // MARK: - Public
    public func updateItem<I: Item>(_ item: I, forKey key: Key) throws where I.Value == Any {
        try _updateItem(AnyItem(item), key)
    }
    
    public func removeItem(forKey key: Key) {
        _removeItem(key)
    }
    
    public func setValue(_ value: Any?) throws {
        try _setValue(value)
    }
    
    public func encode() throws -> Data? {
        try _encode()
    }
    
    public func decode(from data: Data) throws {
        try _decode(data)
    }
    
    // MARK: - Private
}
