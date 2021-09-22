//
//  Slot.swift
//  Runsquito
//
//  Created by jsilver on 2021/08/31.
//

import Foundation

public protocol Slot {
    associatedtype Value
    
    /// Current set value.
    var value: Value? { get }
    /// Storage store value type adopt `Item` protocol.
    /// Property couldn't define as `Item` protocol that has associated type `Value`. So define type erased `Item` as `AnyItem` to implement polymorphism.
    var storage: [Key: AnyItem] { get }
    /// Description of slot.
    var description: String? { get }
    
    /// Add item into storage.
    func updateItem<I: Item>(_ item: I, forKey key: Key) throws where I.Value == Value
    /// Remove item for key from storage.
    func removeItem(forKey key: Key)
    /// Set current value.
    func setValue(_ value: Value?) throws
}

extension Slot {
    func eraseToAnySlot() -> AnySlot {
        AnySlot(self)
    }
}
