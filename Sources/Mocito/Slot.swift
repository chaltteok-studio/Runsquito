//
//  Slot.swift
//  Mocito
//
//  Created by jsilver on 2021/08/29.
//

import Foundation

open class Slot {
    public let type: Any.Type
    public let description: String?
    
    public private(set) var value: Value?
    public private(set) var container: [Key: Mock]
    
    public init(type: Any.Type, description: String? = nil, container: [Key: Mock] = [:]) {
        self.type = type
        self.description = description
        self.container = container
    }
    
    open func add(_ mock: Mock, for key: Key) throws {
        guard Swift.type(of: mock.value) == type else {
            throw MocitoError.typeMismatch
        }
        
        container[key] = mock
    }
    
    open func remove(for key: Key) {
        container[key] = nil
    }
    
    open func set(_ value: Value?) throws {
        if let value = value, Swift.type(of: value) != type {
            throw MocitoError.typeMismatch
        }
        
        self.value = value
    }
    
    open func value<T>(_ type: T.Type) -> T? {
        value as? T
    }
}
