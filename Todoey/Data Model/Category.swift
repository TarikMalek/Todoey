//
//  Category.swift
//  Todoey
//
//  Created by Tarik M on 9/17/19.
//  Copyright © 2019 Tarik M. All rights reserved.
//

import Foundation
import RealmSwift


class Category : Object {
    
    @objc dynamic var name : String = ""
    let items = List<Item>()
}
