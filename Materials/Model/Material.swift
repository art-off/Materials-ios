//
//  Material.swift
//  Materials
//
//  Created by art-off on 22.07.2020.
//  Copyright © 2020 art-off. All rights reserved.
//

import UIKit

class Material: Decodable {
    
    var id: Int = 0
    var name: String = ""
    var section: String = ""
    var date: String = ""
    var files: Files = Files()
    var keywords: [String] = []
    var tests: [Test] = []
    
}

class Files: Decodable {
    
    var doc: String = ""
    var add: [String] = []
    
}

class Test: Decodable {
    
    var question: String = ""
    var answer1: String = ""
    var answer2: String = ""
    var answer3: String = ""
    var answer4: String = ""
    var correctAnswer: Int = 0
    
    enum CodingKeys: String, CodingKey {
        case question = "question"
        case answer1 = "answer1"
        case answer2 = "answer2"
        case answer3 = "answer3"
        case answer4 = "answer4"
        case correctAnswer = "correct_answer"
    }
    
}
