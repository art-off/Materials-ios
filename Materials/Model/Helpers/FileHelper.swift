//
//  FileHelper.swift
//  Materials
//
//  Created by art-off on 13.08.2020.
//  Copyright © 2020 art-off. All rights reserved.
//

import Foundation

class FileHelper {
    
    // MARK: - Get info from file name
    static func getFileNumber(fileName: String) -> Int? {
        guard let substrRange1 = fileName.range(of: "\\([0-9]+\\)", options: .regularExpression) else { return nil }
        let numberWithBrackets = fileName[substrRange1]
        
        guard let substrRange2 = numberWithBrackets.range(of: "[0-9]+", options: .regularExpression) else { return nil }
        let stringNumber = numberWithBrackets[substrRange2]
        
        guard let number = Int(stringNumber) else { return nil }
        return number
    }
    
    static func getFileExtension(fileName: String) -> String? {
        guard let substrRange1 = fileName.range(of: "\\.\\w+", options: .regularExpression) else { return nil }
        let extensionWithDot = fileName[substrRange1]
        
        guard let substrRange2 = extensionWithDot.range(of: "\\w+", options: .regularExpression) else { return nil }
        let ext = String(extensionWithDot[substrRange2])
        
        return ext
    }
    
    static func getFilaNameWithTxtFromDoc(fileName: String) -> String? {
        let nameAndExtension = fileName.split(separator: ".")
        let name = String(nameAndExtension[0])
        let ext = String(nameAndExtension[1])
        
        guard (ext == "docx" || ext == "doc") else { return nil }
        
        return name + ".txt"
    }
    
    // MARK: - Для работы с API
    static func getTxtFileTextFromApiOrLocal(withName fileName: String, complition: @escaping (String?) -> Void) {
        ApiManager.downloadFile(withFileName: fileName) { isDone in
            if isDone {
                // вставить еще ошубку, если доберусь
                getTxtFileTextFromLocal(withname: fileName) { text in
                    complition(text)
                }
            } else {
                getTxtFileTextFromLocal(withname: fileName) { text in
                    complition(text)
                }
            }
        }
    }
    
    private static func getTxtFileTextFromLocal(withname fileName: String, complition: @escaping (String?) -> Void) {
        let fileUrl = DataManager.shared.getFilesDirectoryUrl()
            .appendingPathComponent(fileName)
        
        let text = try? String(contentsOf: fileUrl, encoding: .utf8)
        complition(text)
    }
    
    // Только png, jpg, jpeg, mp3, gif, mp4
    
    // png
    // jpg
    // gif
    
    // mp3
    // mp4
    
    // docx
}
