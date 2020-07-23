//
//  Common.swift
//  Materials
//
//  Created by art-off on 22.07.2020.
//  Copyright © 2020 art-off. All rights reserved.
//

import UIKit

class Common {
    
    static func getMaterial1() -> Material {
        let files = Files()
        files.doc = "1(0).docx"
        files.add = ["1(1).jpg", "1(2).gif"]
        
        let test1 = Test()
        test1.question = "1 вопрос"
        test1.answer1 = "1 ответ"
        test1.answer2 = "2 ответ"
        test1.answer3 = "3 ответ"
        test1.answer4 = "4 ответ"
        test1.correctAnswer = 1
        
        let test2 = Test()
        test2.question = "2 вопрос"
        test2.answer1 = "1 ответ"
        test2.answer2 = "2 ответ"
        test2.answer3 = "3 ответ"
        test2.answer4 = "4 ответ"
        test2.correctAnswer = 2
        
        let material = Material()
        material.id = 1
        material.name = "Инструктаж по технике безопасности для программистов-инженеров"
        material.section = "Техника безопасности"
        material.date = "2020-06-24"
        material.files = files
        material.tests = [test1, test2]
        
        return material
    }
    
    static func getMaterial2() -> Material {
        let files = Files()
        files.doc = "2(0).docx"
        files.add = ["2(1).jpg"]
        
        let test1 = Test()
        test1.question = "1 вопрос"
        test1.answer1 = "1 ответ"
        test1.answer2 = "2 ответ"
        test1.answer3 = "3 ответ"
        test1.answer4 = "4 ответ"
        test1.correctAnswer = 1
        
        let test2 = Test()
        test2.question = "2 вопрос"
        test2.answer1 = "1 ответ"
        test2.answer2 = "2 ответ"
        test2.answer3 = "3 ответ"
        test2.answer4 = "4 ответ"
        test2.correctAnswer = 2
        
        let material = Material()
        material.id = 2
        material.name = "Памятка о работе с высоковольтными проводами"
        material.section = "Памятка"
        material.date = "2020-07-05"
        material.files = files
        material.tests = [test1, test2]

        return material
    }
    
    static func getMaterial3() -> Material {
        let files = Files()
        files.doc = "3(0).docx"
        files.add = ["3(1).jpg"]
        
        let test1 = Test()
        test1.question = "1 вопрос"
        test1.answer1 = "1 ответ"
        test1.answer2 = "2 ответ"
        test1.answer3 = "3 ответ"
        test1.answer4 = "4 ответ"
        test1.correctAnswer = 1
        
        let test2 = Test()
        test2.question = "2 вопрос"
        test2.answer1 = "1 ответ"
        test2.answer2 = "2 ответ"
        test2.answer3 = "3 ответ"
        test2.answer4 = "4 ответ"
        test2.correctAnswer = 2
        
        let material = Material()
        material.id = 3
        material.name = "Принцип работы с компьютером на улице"
        material.section = "Памятка"
        material.date = "2020-07-21"
        material.files = files
        material.tests = [test1, test2]

        return material
    }
    
    static func getMaterials() -> [Material] {
        return [getMaterial3(), getMaterial2(), getMaterial1()]
    }
    
}
