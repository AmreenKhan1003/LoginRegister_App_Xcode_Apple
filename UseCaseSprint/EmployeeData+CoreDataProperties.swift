//
//  EmployeeData+CoreDataProperties.swift
//  UseCaseSprint
//
//  Created by Capgemini-DA322 on 8/18/22.
//
//

import Foundation
import CoreData


extension EmployeeData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<EmployeeData> {
        return NSFetchRequest<EmployeeData>(entityName: "EmployeeData")
    }

    @NSManaged public var nameData: String?
    @NSManaged public var emailData: String?
    @NSManaged public var mobileData: String?
    @NSManaged public var passwordData: String?

}

extension EmployeeData : Identifiable {

}
