//
//  Item.swift
//  Get it Done!
//
//  Created by PAUL LAUGESEN on 4/3/18.
//  Copyright © 2018 PAUL LAUGESEN. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var text : String = ""
    @objc dynamic var isChecked : Bool = false
//    var dateCreated : Date = Date()
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
