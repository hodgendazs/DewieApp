//
//  License.swift
//  DewieApp
//
//  Created by Thomas Hodge on 5/28/24.
//

import Foundation
import SwiftData

enum LicenseSchemaV1: VersionedSchema {
    static var versionIdentifier: Schema.Version = Schema.Version(1, 0, 0)
    
    static var models: [any PersistentModel.Type] {
        [License.self]
    }
    
    @Model
    final class License {
        var id: UUID
        var licenseCode: String
        var licenseCreationDate: String
        var licenseUpdateDate: String
        var licenseExpirationDate: String
        var licenseDepartmentName: String
        
        init(id: UUID, licenseCode: String, licenseCreationDate: String, licenseUpdateDate: String, licenseExpirationDate: String, licenseDepartmentName: String) {
            self.id = id
            self.licenseCode = licenseCode
            self.licenseCreationDate = licenseCreationDate
            self.licenseUpdateDate = licenseUpdateDate
            self.licenseExpirationDate = licenseExpirationDate
            self.licenseDepartmentName = licenseDepartmentName
        }
    }
    
}
// MARK: To be used at a later date if we need to migrate schemas to a new schema (lightweight if not a complex migration, custom if Uniques need to get resolved)
//enum LicenseMigrationPlan: SchemaMigrationPlan {
//    static var schemas: [any VersionedSchema.Type] {
//        [LicenseSchemaV1.self, LicenseSchemaV2.self]
//    }
//
//    static var stages: [MigrationStage] {
//        [migrateV1toV2]
//    }
//
//    static let migrateV1toV2 = MigrationStage.lightweight(fromVersion: LicenseSchemaV1.self, toVersion: LicenseSchemaV2.self)
//}

