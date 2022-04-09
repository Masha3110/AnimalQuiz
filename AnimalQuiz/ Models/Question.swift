//
//  Question.swift
//  AnimalQuiz
//
//  Created by SubZero on 09.04.2022.
//

enum ResponseType {
    case single
    case multiple
    case range
}


struct Question {
    let text: String
    let type: ResponseType
    let answers: [Answer]
}


extension Question {
    static func getQuestion() -> [Question] {
        return [
            Question.init(text: "Какую пищу вы предпочитаете?",
                          type: .single,
                          answers: [
                            Answer(text: "Стейк", type: .dog),
                            Answer(text: "Рыба", type: .cat),
                            Answer(text: "Морковь", type: .rabbit),
                            Answer(text: "Кукуруза", type: .turtle)
                          ]
                         ),
            Question.init(text: "Что вы любите делать?",
                          type: .multiple,
                          answers: [
                            Answer(text: "Плавать", type: .dog),
                            Answer(text: "Спать", type: .cat),
                            Answer(text: "Обниматься", type: .rabbit),
                            Answer(text: "Есть", type: .turtle)
                          ]
                         ),
            Question.init(text: "Любите ли вы поездки на машине?",
                          type: .range,
                          answers: [
                            Answer(text: "Обожаю", type: .dog),
                            Answer(text: "Обожаю", type: .cat),
                            Answer(text: "Ненавижу", type: .rabbit),
                            Answer(text: "Ненавижу", type: .turtle)
                          ]
                         ),
        ]
    }
}
