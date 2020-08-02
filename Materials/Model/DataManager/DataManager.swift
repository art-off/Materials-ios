//
//  DataManager.swift
//  Materials
//
//  Created by art-off on 23.07.2020.
//  Copyright © 2020 art-off. All rights reserved.
//

import RealmSwift

class DataManager {
    
    static let shared = DataManager()
    
    private let realm: Realm
    
    init() {
        let fileManager = FileManager.default
        
        // Создаем директорию в Documents
        let materialsURL = try! fileManager
            .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("Transneft-materials")
        
        if !fileManager.fileExists(atPath: materialsURL.path) {
            do {
                try fileManager.createDirectory(at: materialsURL, withIntermediateDirectories: true, attributes: nil)
            } catch {
                NSLog("Не выходит создать папку в Document директории")
            }
        }
        
        let realmURL = materialsURL.appendingPathComponent("Transneft-materials-realm.realm")
        let realmConfig = Realm.Configuration(fileURL: realmURL)
        
        realm = try! Realm(configuration: realmConfig)
        
        print(realmURL)
    }
    
}

// MARK: - Material
extension DataManager {
    
    // MARK: - Get
    func getMaterials() -> Results<Material> {
        let materials = realm.objects(Material.self)
        return materials
    }
    
    func getMaterial(withId id: Int) -> Material? {
        let optionalMaterial = realm.object(ofType: Material.self, forPrimaryKey: id)
        return optionalMaterial
    }
    
    // MARK: - Delete
    func deleteMaterial(withId id: Int) {
        guard let material = getMaterial(withId: id) else { return }
        try? realm.write {
            realm.delete(material, cascading: true)
        }
    }
    
    func delete(materials: [Material]) {
        for material in materials {
            deleteMaterial(withId: material.id)
        }
    }
    
    // MARK: - Write
    func write(material: Material) {
        // ОЧЕНЬ ВАЖНАЯ СТРОКА: УДАЛЯЕТ СНАЧАЛА ПОЛНОСТЬЮ МАТЕРИАЛ И ВСЕ ЕГО ЗАВИСИМЫЕ ЕЛЕМЕНТЫ
        //deleteMaterial(withId: material.id)
        try? realm.write {
            realm.add(material, update: .modified)
        }
    }
    
    func write(materials: [Material]) {
        for material in materials {
            write(material: material)
        }
    }
    
}

// MARK: - User
extension DataManager {
    
    // MARK: - Get
    func getUsers() -> Results<User> {
        let user = realm.objects(User.self)
        return user
    }
    
    // MARK: - Write
    func write(user: User) {
        try? realm.write {
            realm.add(user, update: .all)
        }
    }
    
    // MARK: - Delete
    func delete(user: User) {
        try? realm.write {
            realm.delete(user)
        }
    }
    
}
