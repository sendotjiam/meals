//
//  BaseErrors.swift
//  Meals
//
//  Created by Sendo Tjiam on 22/09/23.
//

import Foundation

enum BaseErrors: Error, Equatable {
    case networkResponseError
    case decodeError
    case emptyDataError
    case httpError(_ code: Int)
    case anyError
    case urlError
    
    static func == (lhs: BaseErrors, rhs: BaseErrors) -> Bool {
        switch (lhs, rhs) {
        case (.networkResponseError, .networkResponseError), (.decodeError, .decodeError), (.emptyDataError, .emptyDataError), (.httpError(_), .httpError(_)), (.anyError, .anyError), (.urlError, .urlError): return true
        default: return false
        }
    }
}
