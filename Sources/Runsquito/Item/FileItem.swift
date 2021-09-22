//
//  FileItem.swift
//  Runsquito
//
//  Created by jsilver on 2021/09/01.
//

import Foundation

public struct FileItem<Value>: Item {
    // MARK: - Property
    public let value: Value
    public let description: String?
    
    // MARK: - Initializer
    public init?(description: String? = nil, fileName: String, ext: String, in bundle: Bundle = .main) where Value: Decodable {
        let decoder = JSONDecoder()
        
        guard let url = bundle.url(forResource: fileName, withExtension: ext),
              let data = try? Data(contentsOf: url),
              let value = try? decoder.decode(Value.self, from: data) else { return nil }
        
        self.description = description
        self.value = value
    }
    
    // MARK: - Public
    
    // MARK: - Private
}
