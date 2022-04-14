//
//  ResultViewController.swift
//  AnimalQuiz
//
//  Created by SubZero on 09.04.2022.
//

import UIKit

class ResultViewController: UIViewController {
    @IBOutlet var resultLabel: UILabel!
    @IBOutlet var resultDefinition: UILabel!
    
     var answers: [Answer]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        updateResults()
    }
    
    deinit {
        print("ResultViewController has been dealocated")
    }
}
//MARK: - Private Methods
extension ResultViewController {
    private func updateResults() {
        var frequencyOfAnimals: [AnimalType:Int] = [:]
        let animals = answers.map { $0.type }
        
        for animal in animals {
            if let animalTypeCount = frequencyOfAnimals[animal] {
                frequencyOfAnimals.updateValue(animalTypeCount+1, forKey: animal)
            } else {
                frequencyOfAnimals[animal] = 1
            }
        }
        
        let sortedFrequencyOfAnimals = frequencyOfAnimals.sorted { $0.value > $1.value }
        guard let mostFrequencyAnimal = sortedFrequencyOfAnimals.first?.key else { return }
        
        updateUI(with: mostFrequencyAnimal)
    }
    
    private func updateUI(with animal: AnimalType?) {
        resultLabel.text = "Вы - \(animal?.rawValue ?? "🐶")!"
        resultDefinition.text = animal?.definition ?? ""
    }
}
