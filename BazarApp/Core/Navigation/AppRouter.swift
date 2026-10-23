//
//  AppRouter.swift
//  BazarApp
//
//  Created by Elchın on 22.10.26.
//

import Observation

@MainActor
@Observable
final class AppRouter {
    var root: AppRoot = .splash
    var authPath: [AuthRoute] = []
}
