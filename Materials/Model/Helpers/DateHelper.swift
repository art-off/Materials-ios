//
//  DateHelper.swift
//  Materials
//
//  Created by art-off on 25.08.2020.
//  Copyright © 2020 art-off. All rights reserved.
//

import Foundation

class DateHelper {
    
    static func getTodayDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        return dateFormatter.string(from: Date())
    }
    
}
