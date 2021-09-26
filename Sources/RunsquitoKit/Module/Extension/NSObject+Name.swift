//
//  NSObject+Name.swift
//  RunsquitoKit
//
//  Created by jsilver on 2021/09/26.
//

import Foundation

extension NSObject {
    static var name: String { String(describing: Self.self) }
}
