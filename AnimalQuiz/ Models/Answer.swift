//
//  Answer.swift
//  AnimalQuiz
//
//  Created by SubZero on 09.04.2022.
//
enum AnimalType: String {
    case dog = "🐶"
    case cat = "🐱"
    case rabbit = "🐰"
    case turtle = "🐢"
    
    var definition: String {
        switch self {
        case .dog:
            return "Собака"
        case .cat:
            return "Кошка"
        case .rabbit:
            return "Кролик"
        case .turtle:
            return "Черепаха"
        }
    }
}

struct Answer {
    let text: String
    let type: AnimalType
}
