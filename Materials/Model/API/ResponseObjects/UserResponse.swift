//
//  UserResponse.swift
//  Materials
//
//  Created by art-off on 26.07.2020.
//  Copyright © 2020 art-off. All rights reserved.
//

import Foundation

struct UserResponse: Decodable {
    
    let id: Int
    
    let surname: String
    let name: String
    let patronymic: String
    
    let email: String
    let position: String
    let organization: String
    
    var materials: [String: String]
    
}
