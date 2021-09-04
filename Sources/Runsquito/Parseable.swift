//
//  Parseable.swift
//  Runsquito
//
//  Created by jsilver on 2021/08/31.
//

import Foundation

public protocol Parseable {
    static func encode(_ value: Self) throws -> Data
    static func decode(_ data: Data) throws -> Self
}
