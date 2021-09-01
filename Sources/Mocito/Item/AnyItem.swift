//
//  AnyItem.swift
//  Mocito
//
//  Created by jsilver on 2021/08/31.
//

import Foundation

/// Type erased `Item`.
public struct AnyItem: Item {
    // MARK: - Property
    public let type: Any.Type
    
    public let value: Any
    public let description: String?
    
    // MARK: - Intializer
    init<I: Item>(_ item: I) {
        self.type = I.Value.self
        self.value = item.value
        self.description = item.description
    }
    
    // MARK: - Public
    
    // MARK: - Private
}
