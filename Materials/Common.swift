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
        let material = Material(
            id: 1,
            name: "Инструктаж по технике безопасности для программистов-инженеров",
            section: "Техника безопасности",
            date: "2020-06-24",
            files: Files(doc: "1(0).docx", add: ["1(1).jpg", "1(2).gif"]),
            keywords: ["инструктаж", "по", "технике"],
            tests: [
                Test(
                    question: "1 вопрос",
                    answer1: "1 ответ",
                    answer2: "2 ответ",
                    answer3: "3 ответ",
                    answer4: "4 ответ",
                    correctAnswer: 2),
                Test(
                    question: "2 ответ",
                    answer1: "1 ответ",
                    answer2: "2 ответ",
                    answer3: "3 ответ",
                    answer4: "4 ответ",
                    correctAnswer: 3)
        ])
        return material
    }
    
    static func getMaterial2() -> Material {
        let material = Material(
            id: 2,
            name: "Памятка о работе с высоковольтными проводами",
            section: "Памятка",
            date: "2020-07-05",
            files: Files(doc: "2(0).docx", add: ["2(1).jpg"]),
            keywords: ["амятка", "работе", "высоковольтными"],
            tests: [
                Test(
                    question: "1 вопрос",
                    answer1: "1 ответ",
                    answer2: "2 ответ",
                    answer3: "3 ответ",
                    answer4: "4 ответ",
                    correctAnswer: 1),
                Test(
                    question: "2 ответ",
                    answer1: "1 ответ",
                    answer2: "2 ответ",
                    answer3: "3 ответ",
                    answer4: "4 ответ",
                    correctAnswer: 3)
        ])
        return material
    }
    
    static func getMaterial3() -> Material {
        let material = Material(
            id: 3,
            name: "Принцип работы с компьютером на улице",
            section: "Памятка",
            date: "2020-07-21",
            files: Files(doc: "2(0).docx", add: ["2(1).jpg"]),
            keywords: ["амятка", "работе", "высоковольтными"],
            tests: [
                Test(
                    question: "1 вопрос",
                    answer1: "1 ответ",
                    answer2: "2 ответ",
                    answer3: "3 ответ",
                    answer4: "4 ответ",
                    correctAnswer: 1),
                Test(
                    question: "2 ответ",
                    answer1: "1 ответ",
                    answer2: "2 ответ",
                    answer3: "3 ответ",
                    answer4: "4 ответ",
                    correctAnswer: 3)
        ])
        return material
    }
    
    static func getMaterials() -> [Material] {
        return [getMaterial3(), getMaterial2(), getMaterial1()]
    }
    
}
