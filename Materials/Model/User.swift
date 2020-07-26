//
//  User.swift
//  Materials
//
//  Created by art-off on 26.07.2020.
//  Copyright © 2020 art-off. All rights reserved.
//

import RealmSwift

class User: Object {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var surname: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var patronymic: String = ""
    @objc dynamic var email: String = ""
    @objc dynamic var position: String = ""
    @objc dynamic var organization: String = ""
    
    var materials = List<DoneMaterial>()
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
}

class DoneMaterial: Object {
    
    @objc dynamic var materialId: Int = 0
    @objc dynamic var doneDate: String = ""
    
}
