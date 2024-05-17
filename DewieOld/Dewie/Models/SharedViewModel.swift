//
//  SharedViewModel.swift
//  Dewie
//
//  Created by Thomas Hodge on 3/15/24.
//

import Foundation

class SharedViewModel: ObservableObject {
    @Published var dateTimeString: String
    @Published var caseNumber: String
    
    init(dateTimeString: String, caseNumber: String) {
        self.dateTimeString = dateTimeString
        self.caseNumber = caseNumber
    }
}
