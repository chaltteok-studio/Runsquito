//
//  ValueItem.swift
//  Runsquito
//
//  Created by jsilver on 2021/08/29.
//

import Foundation

public struct ValueItem<Value>: Item {
    // MARK: - Property
    public let value: Value
    public let description: String?
    
    // MARK: - Initializer
    public init(_ value: Value, description: String? = nil) {
        self.value = value
        self.description = description
    }
    
    // MARK: - Public
    
    // MARK: - Private
}
