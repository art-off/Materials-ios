//
//  UserHelpers.swift
//  Materials
//
//  Created by art-off on 01.08.2020.
//  Copyright © 2020 art-off. All rights reserved.
//

import RealmSwift

class UserHelpers {
    
    static func authUser(user: User) {
        // удаляем всех юзеров (он только один, но на всякий случай)
        let users = DataManager.shared.getUsers()
        for user in users {
            DataManager.shared.delete(user: user)
        }
        
        // записываем единтсвенного юзера
        DataManager.shared.write(user: user)
    }
    
    static func getCurrUser() -> User? {
        // берем первого юзаре, потому что он должен быть единственный
        let optionalUser = DataManager.shared.getUsers().first
        return optionalUser
    }
    
}
