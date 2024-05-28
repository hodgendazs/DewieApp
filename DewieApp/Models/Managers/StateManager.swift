//
//  StateManager.swift
//  DewieApp
//
//  Created by Thomas Hodge on 5/24/24.
//

import Foundation

class StateManager: ObservableObject {
    @Published var navigateToLoadingScreen: Bool = true
    @Published var navigateToWelcomeScreen: Bool = false
    @Published var navigateToHomeScreen: Bool = false
    @Published var navigateToDepartmentLoginScreen: Bool = false
}
