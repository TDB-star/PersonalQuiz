//
//  Model.swift
//  PersonalQuiz
//
//  Created by Tatiana Dmitrieva on 20/07/2021.
//

import Foundation

struct Question {
    let title: String
    let type: ResponseType
    let answers: [Answer]
    
    static func getQuestions() -> [Question] {
        [
            Question(title: "What kind of food do you like to eat?", type: .single, answers: [Answer(title: "Steak", type: .dog),
                Answer(title: "Fish", type:.cat),
                Answer(title: "Carrots", type: .rabbit),
                Answer(title: "Kukuru", type: .turtle)]),
            Question(title: "What do you like best?", type: .multiple, answers: [Answer(title: "Swim", type: .dog),
                Answer(title: "Sleep", type: .cat),
                Answer(title: "Embrace", type: .rabbit),
                Answer(title: "Eat", type: .turtle)]),
            Question(title: "Do you like traveling by car?", type: .ranged, answers: [Answer(title: "I hate it", type: .cat),
                Answer(title: "Nerving", type: .turtle),
                Answer(title: "I don't notice", type: .rabbit),
                Answer(title: "I love it", type: .dog)])
        ]
    }
}

struct Answer {
    let title: String
    let type: AnimalType
}

enum ResponseType {
    case single
    case multiple
    case ranged
}

enum AnimalType: Character {
    case dog = "🐶"
case cat = "🐱"
     case rabbit = "🐰"
    case turtle = "🐢"
    
    var definition: String {
        switch self {
        case .dog:
            return "Dogs waiting for their frends to add them back to the group chat after they left dramatically."
        case .cat:
            return "Though seemingly detached, Cats are attracted to witty and smart people. If you are a friend with Cats, consider it a compliment!"
        case .rabbit:
            return "One good point about Rabbits is their generosity. Another good point is that they are very enthusiastic. And one bad point about Rabbits is that what they are most enthusiastically generous with is in fact other people’s stuff."
        case .turtle:
            return "Turtles are artistic people who daydream a lot. Their daydreaming has resulted in some of the world’s greatest works of art – and worst traffic accidents. The Highway Code actually suggests that if you find yourself driving behind a Turtle, you should honk your horn loudly at least every 15 seconds as a basic precaution.."
        }
    }
}
