//
//  CodableSlot.swift
//  Runsquito
//
//  Created by jsilver on 2021/08/31.
//

import Foundation

open class CodableSlot<Value>: ValueSlot<Value>, EditableSlot where Value: Codable {
    // MARK: - Property
    
    // MARK: - Initializer
    
    // MARK: - Publlic
    open func encode() throws -> Data? {
        guard let value = value else { return nil }
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        return try encoder.encode(value)
    }
    
    open func decode(from data: Data) throws {
        let decoder = JSONDecoder()
        let value = try decoder.decode(Value.self, from: data)
        
        setValue(value)
    }
    
    // MARK: - Private
}
