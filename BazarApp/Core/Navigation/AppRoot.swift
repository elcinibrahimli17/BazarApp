//
//  AppRoot.swift
//  BazarApp
//
//  Created by Elchın on 22.10.26.
//

import Foundation

enum AppRoot {
    case splash
    case onboarding
    case auth
    case pin(PinMode)
    case main
}
