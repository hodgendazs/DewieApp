//
//  String+Extensions.swift
//  Dewie
//
//  Created by Thomas Hodge on 3/18/24.
//

import Foundation

extension String {
    
    var isEmptyOrWhiteSpace: Bool {
        self.trimmingCharacters(in: .whitespaces).isEmpty
    }
}
