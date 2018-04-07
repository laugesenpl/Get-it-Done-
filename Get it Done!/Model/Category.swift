//
//  Category.swift
//  Get it Done!
//
//  Created by PAUL LAUGESEN on 4/3/18.
//  Copyright © 2018 PAUL LAUGESEN. All rights reserved.
//

import Foundation
import RealmSwift

class Category : Object {
    @objc dynamic var name : String = ""
    let items = List<Item>()
}
