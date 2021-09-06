//
//  ParseableSlot.swift
//  Runsquito
//
//  Created by jsilver on 2021/08/29.
//

import Foundation

open class ParseableSlot<Value>: ValueSlot<Value>, Editable where Value: Parseable {
    // MARK: - Prorperty
    
    // MARK: - Initializer
    
    // MARK: - Public
    open func encode() throws -> Data? {
        guard let value = value else { return nil }
        return try Value.encode(value)
    }
    
    open func decode(_ data: Data) throws {
        set(try Value.decode(data))
    }
    
    // MARK: - Private
}
