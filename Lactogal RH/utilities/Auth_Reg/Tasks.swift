//
//  Tasks.swift
//  Lactogal RH
//
//  Created by Mauro Jorge Costa dos Santos Benedito on 27/02/2019.
//  Copyright © 2019 Mauro Jorge Costa dos Santos Benedito. All rights reserved.
//

import UIKit

class Tasks {
    var question: String
    var state: Int
    var answer: String
    var category: String
    
    init(question: String, answer: String, state: Int, category: String) {
        self.question = question
        self.answer = answer
        self.state = state
        self.category = category
    }
    
    
    enum PostResult {
        case success(Bool), failure(Error)
    }
    
}
