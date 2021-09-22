//
//  Parseable.swift
//  Runsquito
//
//  Created by jsilver on 2021/08/31.
//

import Foundation

public protocol Parseable {
    func encode() throws -> Data
    static func decode(from data: Data) throws -> Self
}
