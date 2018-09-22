//
//  Category.swift
//  Todo3000
//
//  Created by Todd Matthews on 9/21/18.
//  Copyright © 2018 Todd Matthews. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    let items = List<Item>()
}
