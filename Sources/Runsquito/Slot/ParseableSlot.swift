//
//  ParseableSlot.swift
//  Runsquito
//
//  Created by jsilver on 2021/08/29.
//

import Foundation

open class ParseableSlot<Value>: ValueSlot<Value>, EditableSlot where Value: Parseable {
    // MARK: - Prorperty
    
    // MARK: - Initializer
    
    // MARK: - Public
    open func encode() throws -> Data? {
        guard let value = value else { return nil }
        return try value.encode()
    }
    
    open func decode(from data: Data) throws -> Value {
        return try Value.decode(from: data)
    }
    
    // MARK: - Private
}
