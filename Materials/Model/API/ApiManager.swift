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
    
    static func loadUser(withEmail email: String, password: String, complition: @escaping (User?) -> Void) {
        let url = API.getUser()
        
        let parameters = [
            "secret": API.key,
            "email": email,
            "password_hash": password.md5
        ]
        
        let boundary = "Boundary-\(UUID().uuidString)"
        
        let httpBody = httpBodyForMultipart(withParameters: parameters, boundary: boundary)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.httpBody = httpBody
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
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
                let userResponse = try JSONDecoder().decode(UserResponse.self, from: data)
                
                let user = User()
                user.id = userResponse.id
                user.surname = userResponse.surname
                user.name = userResponse.name
                user.patronymic = userResponse.patronymic
                user.email = userResponse.email
                user.organization = userResponse.organization
                user.position = userResponse.position

                for (materialId, date) in userResponse.materials {
                    if let materialId = Int(materialId) {
                        let doneMaterial = DoneMaterial()
                        doneMaterial.materialId = materialId
                        doneMaterial.doneDate = date
                        user.materials.append(doneMaterial)
                    }
                }
                
                complition(user)
            } catch let jsonError {
                print(jsonError)
                complition(nil)
            }
        }
        
        task.resume()
        
    }
    
}


// MARK: - For multipart/form-data
extension ApiManager {
    
    private static func httpBodyForMultipart(withParameters parameters: [String: String], boundary: String) -> Data {
        var httpBody = Data()
        for (key, value) in parameters {
            httpBody.append(Data(convertFormField(named: key, value: value, using: boundary).utf8))
        }
        httpBody.append(Data("--\(boundary)--".utf8))
        
        return httpBody
    }
    
    private static func convertFormField(named name: String, value: String, using boundary: String) -> String {
        var fieldString = "--\(boundary)\r\n"
        fieldString += "Content-Disposition: form-data; name=\"\(name)\"\r\n"
        fieldString += "\r\n"
        fieldString += "\(value)\r\n"

        return fieldString
    }
    
}
