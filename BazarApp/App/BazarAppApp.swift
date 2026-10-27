//
//  BazarAppApp.swift
//  BazarApp
//
//  Created by Elchın on 22.10.26.
//

import SwiftUI
import FirebaseCore

@main
struct BazarAppApp: App {
    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}
