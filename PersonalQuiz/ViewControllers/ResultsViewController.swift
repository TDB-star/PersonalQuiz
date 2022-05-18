//
//  ResultsViewController.swift
//  PersonalQuiz
//
//  Created by Tatiana Dmitrieva on 21/07/2021.
//

import UIKit

class ResultsViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var definitionLabel: UILabel!
    
    var answerChoosen: [Answer]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        updateResult()
        
    }
    
    private func updateResult() {
        
      var frequencyOfAnimals: [AnimalType: Int] = [:]
      let animals = answerChoosen.map {$0.type}
        
//        for answer in answerChoosen {  эта запись равносильна записи выше, те мы создали // новый массив, который содержит только тип животных
//            animals.append(answer.type)
//        }
 // перебираем наши типы животных и заносим в словарь
        
        for animal in animals {
            if let animalTypeCount = frequencyOfAnimals[animal] {
                frequencyOfAnimals.updateValue(animalTypeCount + 1, forKey: animal)
            } else {
                frequencyOfAnimals[animal] = 1
            }
        }
        let sortedFrequencyOfAnimals = frequencyOfAnimals.sorted { $0.value > $1.value }
        guard let mostFrequencyAnimal = sortedFrequencyOfAnimals.first?.key else { return }
        updateUI(with: mostFrequencyAnimal)
    }
    
    private func updateUI(with animal: AnimalType?) {
        resultLabel.text = "You are - \(animal?.rawValue ?? "👹")"
        definitionLabel.text = animal?.definition ?? ""
    }
}
