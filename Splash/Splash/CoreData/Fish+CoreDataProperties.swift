//
//  Fish+CoreDataProperties.swift
//  Splash
//
//  Created by Ben Lapidus on 12/1/19.
//  Copyright © 2019 Ben Lapidus. All rights reserved.
//
//

import Foundation
import CoreData


extension Fish {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Fish> {
        return NSFetchRequest<Fish>(entityName: "Fish")
    }

    @NSManaged public var dateCaught: NSDate?
    @NSManaged public var name: String?

}
