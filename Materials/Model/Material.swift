//
//  Material.swift
//  Materials
//
//  Created by art-off on 22.07.2020.
//  Copyright © 2020 art-off. All rights reserved.
//

import RealmSwift

class Material: Object, Decodable {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var section: String = ""
    @objc dynamic var date: String = ""
    @objc dynamic var files: Files?
    var keywords = List<String>()
    var tests = List<Test>()
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
}

class Files: Object, Decodable {
    
    @objc dynamic var doc: String = ""
    var add = List<String>()
    
    // разкоментить, чтобы не создавалось очень много объектов в БД
//    override class func primaryKey() -> String? {
//        return "doc"
//    }
}

class Test: Object, Decodable {
    
    @objc dynamic var question: String = ""
    @objc dynamic var answer1: String = ""
    @objc dynamic var answer2: String = ""
    @objc dynamic var answer3: String = ""
    @objc dynamic var answer4: String = ""
    @objc dynamic var correctAnswer: Int = 0
    
    enum CodingKeys: String, CodingKey {
        case question = "question"
        case answer1 = "answer1"
        case answer2 = "answer2"
        case answer3 = "answer3"
        case answer4 = "answer4"
        case correctAnswer = "correct_answer"
    }
    
    // разкоментить, чтобы не создавалось очень много объектов в БД
//    override class func primaryKey() -> String? {
//        return "question"
//    }
    
}
