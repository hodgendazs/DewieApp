//
//  ReturingOfficerView.swift
//  Dewie
//
//  Created by Thomas Hodge on 3/16/24.
//

import SwiftUI

struct DepartmentReturningOfficerScreen: View {
    var body: some View {
        OfficerListView()
    }
}



#Preview {
    NavigationStack {
        DepartmentReturningOfficerScreen()
            .modelContainer(multipleOfficerPreviewContainer)
    }
}


