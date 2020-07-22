//
//  Material.swift
//  Materials
//
//  Created by art-off on 22.07.2020.
//  Copyright © 2020 art-off. All rights reserved.
//

import UIKit

struct Material {
    
    let id: Int
    let name: String
    let section: String
    let date: String
    let files: Files
    let keywords: [String]
    let tests: [Test]
    
}

struct Files {
    
    let doc: String
    let add: [String]
    
}

struct Test {
    
    let question: String
    let answer1: String
    let answer2: String
    let answer3: String
    let answer4: String
    let correctAnswer: Int
    
}
