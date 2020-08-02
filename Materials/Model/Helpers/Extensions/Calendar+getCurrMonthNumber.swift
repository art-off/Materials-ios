//
//  Calendar+getCurrMonthNumber.swift
//  Materials
//
//  Created by art-off on 02.08.2020.
//  Copyright © 2020 art-off. All rights reserved.
//

import Foundation

extension Calendar {
    
    func getCurrMonthNumber() -> String {
        let monthNumber = Calendar.current.component(.month, from: Date())
        let stringMonthNumber: String
        if monthNumber < 10 {
            stringMonthNumber = "0" + String(monthNumber)
        } else {
            stringMonthNumber = String(monthNumber)
        }
        
        return stringMonthNumber
    }
    
    func getCurrYearNumber() -> String {
        let yearNumber = Calendar.current.component(.year, from: Date())
        return String(yearNumber)
    }
    
}
