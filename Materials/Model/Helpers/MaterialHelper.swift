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
    
    // MARK: Получение материалов последнего месяца
    static func getLastMonthMaterials() -> Results<Material> {
        let monthNumber = Calendar.current.getCurrMonthNumber()
        
        // берем материалы только текущего месяца
        let materials = getAllMaterials().filter("date CONTAINS[c] '-\(monthNumber)-'")
        
        print(materials)
        return materials
    }
    
    // MARK: Получение всех материалов, кроме последнего месяца
    static func getNotLastMonthMaterials() -> Results<Material> {
        let monthNumber = Calendar.current.getCurrMonthNumber()
        
        // берем все материалы, кроме текущего месяца
        let materials = getAllMaterials().filter("NOT date CONTAINS[c] '-\(monthNumber)-'")
        
        print(materials)
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
    
    // MARK: Для получения всех материалов по индексам вместе с датой прохождения
    static func getMaterialsWithDoneDate(doneMaterials: [DoneMaterial]) -> [Material] {
        var materials = [Material]()
        
        for doneMaterial in doneMaterials {
            if let material = DataManager.shared.getMaterial(withId: doneMaterial.materialId)?.newObject() {
                material.date = "Дата прохождения: \(doneMaterial.doneDate)"
                materials.append(material)
            }
        }
        
        materials.sort(by: { $0.date > $1.date })
        
        return materials
    }
    
}
