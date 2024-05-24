//
//  LoadOfficer.swift
//  DewieApp
//
//  Created by Thomas Hodge on 5/21/24.
//

import Foundation
import SwiftData
import SwiftUI

class OfficerManager: ObservableObject {
    @Published var currentOfficer: Officer?
    @Published var isSingleOfficerLoadedFromDatabase: Bool = false
    @Published var isLoading: Bool = true
    @Published var logout: Bool = false
}
