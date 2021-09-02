//
//  RunsquitoError.swift
//  Runsquito
//
//  Created by jsilver on 2021/08/29.
//

import Foundation

enum RunsquitoError: LocalizedError {
    case keyDuplicate(Key)
    case slotNotFound(Key)
    case failToParse(Error?)
    case typeMismatch
    
    var errorDescription: String? {
        switch self {
        case let .keyDuplicate(key):
            return "Add duplicated key(\"\(key)\")."
            
        case let .slotNotFound(key):
            return "Slot not added by key(\"\(key)\")"
            
        case .failToParse:
            return "Fail to parse."
            
        case .typeMismatch:
            return "fail to add because value's type doesn't match already added value."
        }
    }
}
