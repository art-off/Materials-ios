//
//  MaterialsResponse.swift
//  Materials
//
//  Created by art-off on 23.07.2020.
//  Copyright © 2020 art-off. All rights reserved.
//

import Foundation


class MaterialsResponse: Decodable {
    
    var meta: Meta = Meta()
    var materials: [Material] = []
    
    enum CodingKeys: String, CodingKey {
        case meta = "_meta"
        case materials = "items"
    }
    
}

class Meta: Decodable {
    
    var count: Int = 0
    
}
