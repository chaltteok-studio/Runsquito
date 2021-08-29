//
//  MocitoError.swift
//  Mocito
//
//  Created by jsilver on 2021/08/29.
//

import Foundation

enum MocitoError: LocalizedError {
    case keyDuplicate(Key)
    case typeMismatch
    
    var errorDescription: String? {
        switch self {
        case let .keyDuplicate(key):
            return "Add duplicated key(\"\(key)\")."
            
        case .typeMismatch:
            return "fail to add because value's type doesn't match already added value."
        }
    }
}
