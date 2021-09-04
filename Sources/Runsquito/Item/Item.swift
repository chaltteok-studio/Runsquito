//
//  Item.swift
//  Runsquito
//
//  Created by jsilver on 2021/08/31.
//

import Foundation

public protocol Item {
    associatedtype Value
    
    /// Value of item.
    var value: Value { get }
    /// Description of item.
    var description: String? { get }
}
