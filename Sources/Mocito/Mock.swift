//
//  Mock.swift
//  Mocito
//
//  Created by jsilver on 2021/08/29.
//

import Foundation

public struct Mock {
    public let value: Value
    public let description: String?
    
    public init(value: Value, description: String? = nil) {
        self.value = value
        self.description = description
    }
    
    public init?(description: String? = nil, fileName: String, ext: String, in bundle: Bundle = .main) {
        guard let path = bundle.path(forResource: fileName, ofType: ext),
              let value = try? String(contentsOfFile: path) else { return nil }
        
        self.description = description
        self.value = value
    }
}
