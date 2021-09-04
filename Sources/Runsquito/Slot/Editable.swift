//
//  Editable.swift
//  Runsquito
//
//  Created by jsilver on 2021/09/03.
//

import Foundation

public protocol Editable {
    /// Return encoded `Data` from current value of slot.
    func encode() throws -> Data?
    /// Set decoded value from `Data`.
    func decode(_ data: Data) throws
}
