//
//  Array+Sort.swift
//  
//
//  Created by jsilver on 2021/09/26.
//

import Foundation

extension Sequence {
    func sorted<T>(by keyPath: KeyPath<Element, T>) -> [Element] where T: Comparable {
        sorted { $0[keyPath: keyPath] < $1[keyPath: keyPath] }
    }
}
