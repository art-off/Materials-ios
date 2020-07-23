//
//  MaterialHelper.swift
//  Materials
//
//  Created by art-off on 23.07.2020.
//  Copyright © 2020 art-off. All rights reserved.
//

import RealmSwift

class MaterialHelper {
    
    static func getAllMaterials() -> Results<Material> {
        let materials = DataManager.shared.getMaterials().sorted(byKeyPath: "id", ascending: false)
        return materials
    }
    
    // MARK: Для получения словаря материалов с ключем в виде секции
    static func getMaterialsBySections() -> [String: Results<Material>] {
        let materials = getAllMaterials()
        
        var sections = [String]()
        
        for material in materials {
            if !sections.contains(material.section) {
                sections.append(material.section)
            }
        }
        
        var sectionsAndMaterials = [String: Results<Material>]()
        
        for section in sections {
            sectionsAndMaterials[section] = materials.filter("section = '\(section)'")
        }
        
        return sectionsAndMaterials
    }
    
}
