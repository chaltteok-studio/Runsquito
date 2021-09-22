//
//  EditableSlot.swift
//  Runsquito
//
//  Created by jsilver on 2021/09/03.
//

import Foundation

public protocol EditableSlot: Slot {
    /// Return encoded `Data` from current value of slot.
    func encode() throws -> Data?
    /// Set decoded value from `Data`.
    func decode(from data: Data) throws
}

extension EditableSlot {
    func eraseToAnySlot() -> AnySlot {
        AnySlot(editable: self)
    }
}
