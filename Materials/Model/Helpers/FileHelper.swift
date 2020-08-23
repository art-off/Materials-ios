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
    
    // MARK: - Для работы с API
    static func loadFile() {
        
    }
    
    // Только png, jpg, jpeg, mp3, gif, mp4
    
    // png
    // jpg
    // gif
    
    // mp3
    // mp4
    
    // docx
}
