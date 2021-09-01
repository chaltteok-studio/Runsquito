//
//  Primitive+Parseable.swift
//  Mocito
//
//  Created by jsilver on 2021/08/31.
//

import Foundation

extension Int: Parseable {
    public static func encode(_ value: Int) throws -> Data {
        guard let data = String(value).data(using: .utf8) else { throw MocitoError.failToParse(nil) }
        return data
    }
    
    public static func decode(_ data: Data) throws -> Int {
        guard let string = String(data: data, encoding: .utf8),
              let value = Int(string) else { throw MocitoError.failToParse(nil) }
        return value
    }
}

extension Float: Parseable {
    public static func encode(_ value: Float) throws -> Data {
        guard let data = String(value).data(using: .utf8) else { throw MocitoError.failToParse(nil) }
        return data
    }
    
    public static func decode(_ data: Data) throws -> Float {
        guard let string = String(data: data, encoding: .utf8),
              let value = Float(string) else { throw MocitoError.failToParse(nil) }
        return value
    }
}

extension Double: Parseable {
    public static func encode(_ value: Double) throws -> Data {
        guard let data = String(value).data(using: .utf8) else { throw MocitoError.failToParse(nil) }
        return data
    }
    
    public static func decode(_ data: Data) throws -> Double {
        guard let string = String(data: data, encoding: .utf8),
              let value = Double(string) else { throw MocitoError.failToParse(nil) }
        return value
    }
}

extension Bool: Parseable {
    public static func encode(_ value: Bool) throws -> Data {
        guard let data = String(value).data(using: .utf8) else { throw MocitoError.failToParse(nil) }
        return data
    }
    
    public static func decode(_ data: Data) throws -> Bool {
        guard let string = String(data: data, encoding: .utf8),
              let value = Bool(string.lowercased()) else { throw MocitoError.failToParse(nil) }
        return value
    }
}

extension String: Parseable {
    public static func encode(_ value: String) throws -> Data {
        guard let data = value.data(using: .utf8) else { throw MocitoError.failToParse(nil) }
        return data
    }
    
    public static func decode(_ data: Data) throws -> String {
        guard let value = String(data: data, encoding: .utf8) else { throw MocitoError.failToParse(nil) }
        return value
    }
}
