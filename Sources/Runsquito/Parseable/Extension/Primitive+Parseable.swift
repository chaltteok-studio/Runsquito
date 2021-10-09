//
//  Primitive+Parseable.swift
//  Runsquito
//
//  Created by jsilver on 2021/08/31.
//

import Foundation

extension Int: Parseable {
    public func encode() throws -> Data {
        guard let data = String(self).data(using: .utf8) else { throw RunsquitoError.failToParse(nil) }
        return data
    }
    
    public static func decode(from data: Data) throws -> Int {
        guard let string = String(data: data, encoding: .utf8),
              let value = Int(string) else { throw RunsquitoError.failToParse(nil) }
        return value
    }
}

extension Float: Parseable {
    public func encode() throws -> Data {
        guard let data = String(self).data(using: .utf8) else { throw RunsquitoError.failToParse(nil) }
        return data
    }
    
    public static func decode(from data: Data) throws -> Float {
        guard let string = String(data: data, encoding: .utf8),
              let value = Float(string) else { throw RunsquitoError.failToParse(nil) }
        return value
    }
}

extension Double: Parseable {
    public func encode() throws -> Data {
        guard let data = String(self).data(using: .utf8) else { throw RunsquitoError.failToParse(nil) }
        return data
    }
    
    public static func decode(from data: Data) throws -> Double {
        guard let string = String(data: data, encoding: .utf8),
              let value = Double(string) else { throw RunsquitoError.failToParse(nil) }
        return value
    }
}

extension Bool: Parseable {
    public func encode() throws -> Data {
        guard let data = String(self).data(using: .utf8) else { throw RunsquitoError.failToParse(nil) }
        return data
    }
    
    public static func decode(from data: Data) throws -> Bool {
        guard let string = String(data: data, encoding: .utf8),
              let value = Bool(string.lowercased()) else { throw RunsquitoError.failToParse(nil) }
        return value
    }
}

extension String: Parseable {
    public func encode() throws -> Data {
        guard let data = data(using: .utf8) else { throw RunsquitoError.failToParse(nil) }
        return data
    }
    
    public static func decode(from data: Data) throws -> String {
        guard let value = String(data: data, encoding: .utf8) else { throw RunsquitoError.failToParse(nil) }
        return value
    }
}
