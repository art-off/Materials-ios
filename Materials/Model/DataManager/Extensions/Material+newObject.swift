//
//  Material+newObject.swift
//  Materials
//
//  Created by art-off on 01.08.2020.
//  Copyright © 2020 art-off. All rights reserved.
//

import RealmSwift

extension Material {
    
    func newObject() -> Material {
        let material = Material()
        material.id = self.id
        material.name = self.name
        material.section = self.section
        material.date = self.date
        material.files = self.files
        material.keywords = self.keywords
        material.tests = self.tests
        
        return material
    }
    
}
