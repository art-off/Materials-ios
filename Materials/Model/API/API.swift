//
//  API.swift
//  Materials
//
//  Created by art-off on 23.07.2020.
//  Copyright © 2020 art-off. All rights reserved.
//

import Foundation

struct API {
    
    static let address = "http://193.187.172.72/api"
    
    // MARK: Взятие всех материалов
    static func allMaterials() -> URL {
        return URL(string: "\(address)/materials")!
    }
    
    // MARK: Скачивание указанного файла
    static func download(fileName: String) -> URL {
        return URL(string: "\(address)/donwload/\(fileName)")!
    }
    
    // MARK: Получение пользователя (POST)
    static func getUser() -> URL {
        return URL(string: "\(address)/get_user")!
    }
    
    // MARK: Добавление пройденного материала в пройденные материалы (POST)
    static func addMaterial() -> URL {
        return URL(string: "\(address)/add_material")!
    }
    
}
