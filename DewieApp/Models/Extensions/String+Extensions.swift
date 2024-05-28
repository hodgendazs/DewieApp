//
//  File.swift
//  DewieApp
//
//  Created by Thomas Hodge on 5/16/24.
//

import Foundation

extension String {
    
    var isEmptyOrWhiteSpace: Bool {
        self.trimmingCharacters(in: .whitespaces).isEmpty
    }
}
