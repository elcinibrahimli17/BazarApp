//
//  PinError.swift
//  BazarApp
//
//  Created by Elchın on 27.10.26.
//

import Foundation

enum PinError: LocalizedError {
    case saveFailed

    var errorDescription: String? {
        switch self {
        case .saveFailed:
            "Could not save PIN. Please try again."
        }
    }
}
