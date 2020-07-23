//
//  ApiManager.swift
//  Materials
//
//  Created by art-off on 23.07.2020.
//  Copyright © 2020 art-off. All rights reserved.
//

import Foundation

class ApiManager {
    
    static func loadAllMaterials(complition: @escaping ([Material]?) -> Void) {
        let url = API.allMaterials()
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse,
                (200..<300).contains(httpResponse.statusCode) else {
                    complition(nil)
                    return
            }
            
            guard let data = data else {
                complition(nil)
                return
            }
            
            do {
                let materialsResponse = try JSONDecoder().decode(MaterialsResponse.self, from: data)
                complition(materialsResponse.materials)
            } catch let jsonError {
                print(jsonError)
                complition(nil)
            }
        }
        
        task.resume()
    }
    
}
