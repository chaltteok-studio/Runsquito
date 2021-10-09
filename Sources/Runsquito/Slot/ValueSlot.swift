//
//  ValueSlot.swift
//  Runsquito
//
//  Created by jsilver on 2021/09/03.
//

import Foundation

open class ValueSlot<Value>: Slot {
    // MARK: - Prorperty
    public private(set) var value: Value?
    public private(set) var storage: [Key: AnyItem] = [:]
    public let description: String?
    
    // MARK: - Initializer
    public init(
        value: Value? = nil,
        description: String? = nil
    ) {
        self.value = value
        self.description = description
    }
    
    // MARK: - Public
    open func updateItem<I>(_ item: I, forKey key: Key) where I: Item, I.Value == Value {
        storage.updateValue(item.eraseToAnyItem(), forKey: key)
    }
    
    open func removeItem(forKey key: Key) {
        storage.removeValue(forKey: key)
    }
    
    open func setValue(_ value: Value?) {
        self.value = value
    }
    
    // MARK: - Private
}
