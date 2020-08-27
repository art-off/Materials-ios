//
//  ApiManager.swift
//  Materials
//
//  Created by art-off on 23.07.2020.
//  Copyright © 2020 art-off. All rights reserved.
//

import Foundation

class ApiManager {
    
    // MARK: - Load materials
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
    
    // MARK: - Auth
    static func authUser(withEmail email: String, password: String, complition: @escaping (User?, _ isWrongLoginOrPassword: Bool) -> Void) {
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
            guard let httpResponse = response as? HTTPURLResponse else {
                complition(nil, false)
                return
            }
            
            if httpResponse.statusCode == 403 {
                complition(nil, true)
            }
            
            guard (200..<300).contains(httpResponse.statusCode) else {
                complition(nil, false)
                return
            }
            
            guard let data = data else {
                complition(nil, false)
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
                
                complition(user, false)
            } catch let jsonError {
                print(jsonError)
                complition(nil, false)
            }
        }
        
        task.resume()
    }
    
    // MARK: - Add Material
    static func addMaterial(withMaterialId materialId: Int, complition: @escaping (_ isDone: Bool) -> Void) {
        let url = API.addMaterial()
        
        guard let currUserId = UserHelpers.getCurrUser()?.id else {
            complition(false)
            return
        }
        
        let parameters = [
            "secret": API.key,
            "material_id": String(materialId),
            "user_id": String(currUserId),
            "material_date": DateHelper.getTodayDate()
        ]
        
        let boundary = "Boundary-\(UUID().uuidString)"
        let httpBody = httpBodyForMultipart(withParameters: parameters, boundary: boundary)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.httpBody = httpBody
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                complition(false)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                // 404 отправляет, если уже есть такой материал
                (200..<300).contains(httpResponse.statusCode) || httpResponse.statusCode == 404 else {
                    complition(false)
                    return
            }
            
            guard data != nil else {
                complition(false)
                return
            }
            
            // добавление прошло успешно
            complition(true)
            //if httpResponse.statusCode == 200 {
            //    complition(true)
            //} else {
            //    complition(false)
            //}
        }
        
        task.resume()
        
    }
    
    // MARK: - Files
    static func downloadFile(withFileName name: String, complition: @escaping (_ isDone: Bool) -> Void) {
        let url = API.download(fileName: name)
        
        let fileUrl = FileHelper.getUrl(forFileName: name)
        
        let task = URLSession.shared.downloadTask(with: url) { tempLocalUrl, response, error in
            guard let httpResponse = response as? HTTPURLResponse,
                (200..<300).contains(httpResponse.statusCode) else {
                    complition(false)
                    return
            }
            
            guard let tempLocalUrl = tempLocalUrl else {
                complition(false)
                return
            }
            
            do {
                try FileManager.default.copyItem(at: tempLocalUrl, to: fileUrl)
                complition(true)
            } catch let writeError {
                print(writeError)
                complition(false)
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
