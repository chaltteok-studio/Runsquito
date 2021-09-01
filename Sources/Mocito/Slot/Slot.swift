//
//  Slot.swift
//  Mocito
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
    func add<I: Item>(_ item: I, for key: Key) throws where I.Value == Value
    /// Remove item for key from storage.
    func remove(for key: Key)
    /// Set current value.
    func set(_ value: Value?) throws
    
    /// Return encoded `Data` from current value of slot.
    func encode() throws -> Data?
    /// Set decoded value from `Data`.
    func decode(_ data: Data) throws
}
