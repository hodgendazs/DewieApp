//
//  LicenseData.swift
//  DewieApp
//
//  Created by Thomas Hodge on 5/16/24.
//

import Foundation
import SwiftData

@Model
final class License {
    var licenseId: UUID
    var hasMonthlySubscription: Bool
    var monthlySubscriptoinExpirationDate: Date
    var hasYearltSubscription: Bool
    var yearlySubscriptionExpirationDate: Date
    var hasDepartmentCode: Bool
    var departmentCode: String
    var departmentCodeExpirationDate: Date
    
    init(licenseId: UUID = UUID(), hasMonthlySubscription: Bool, monthlySubscriptoinExpirationDate: Date, hasYearltSubscription: Bool, yearlySubscriptionExpirationDate: Date, hasDepartmentCode: Bool, departmentCode: String, departmentCodeExpirationDate: Date) {
        self.licenseId = licenseId
        self.hasMonthlySubscription = hasMonthlySubscription
        self.monthlySubscriptoinExpirationDate = monthlySubscriptoinExpirationDate
        self.hasYearltSubscription = hasYearltSubscription
        self.yearlySubscriptionExpirationDate = yearlySubscriptionExpirationDate
        self.hasDepartmentCode = hasDepartmentCode
        self.departmentCode = departmentCode
        self.departmentCodeExpirationDate = departmentCodeExpirationDate
    }
}
