//
//  QuestionsController.swift
//  AnimalQuiz
//
//  Created by SubZero on 09.04.2022.
//

import UIKit

class QuestionsController: UIViewController {

    
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var rangedSlider: UISlider! {
        didSet {
            let answerCount = Float(currentAnswer.count - 1)
            rangedSlider.value = answerCount
        }
    }
    
    @IBOutlet var singleStackView: UIStackView!
    @IBOutlet var multipleStackView: UIStackView!
    @IBOutlet var rangedStackView: UIStackView!
    
    @IBOutlet var singleButtons: [UIButton]!
    @IBOutlet var multipleLabels: [UILabel]!
    @IBOutlet var rangedLables: [UILabel]!
    @IBOutlet var multipleSwitchs: [UISwitch]!
    
    
    //MARK: Properties
    private let questions = Question.getQuestion()
    private var questionIndex = 0
    private var answerChoosen: [Answer] = []
    private var currentAnswer: [Answer] {
        questions[questionIndex].answers
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    @IBAction func singleButtonAnswerPressed(_ sender: UIButton) {
        guard let currentIndex = singleButtons.firstIndex(of: sender) else {
            return
        }
        let currentAnswer = currentAnswer[currentIndex]
        answerChoosen.append(currentAnswer)
        
        nextQuestion()
    }
    
    @IBAction func multipleButtonPressed() {
        for (multipleSwitch, answer) in zip(multipleSwitchs, currentAnswer) {
            if multipleSwitch.isOn {
                answerChoosen.append(answer)
            }
        }
        nextQuestion()
        
    }
    
    
    @IBAction func rangedButtonPressed() {
        let index = Int(rangedSlider.value)
        answerChoosen.append(currentAnswer[index])
        
        nextQuestion()
    }
    
    
    //MARK: -
}
//MARK: - Private
extension QuestionsController {
    // Hide stacks
    private func updateUI() {
        for stackView in [singleStackView, multipleStackView, rangedStackView] {
            stackView?.isHidden = true
        }
        // get current question
        let currentQuestion = questions[questionIndex]
        
        // set current question for label
        questionLabel.text = currentQuestion.text
        
        // calculate progress
        let totalProgress = Float(questionIndex) / Float(questions.count)
        
        // set progress for progressView
        progressView.setProgress(totalProgress, animated: true)
        
        title = "Вопрос №\(questionIndex+1)  из \(questions.count)"
        
        //show current StackView
        showCurrentStackView(for: currentQuestion.type)
        
    }
    
    private func showCurrentStackView(for type: ResponseType) {
        switch type {
        case .single:
            showSingleStackView(with: currentAnswer)
        case .multiple:
            showMultipleStackView(with: currentAnswer)
        case .range:
            showRangedStackView(with: currentAnswer)
        }
        
    }
    
    private func showSingleStackView(with answers: [Answer]) {
        singleStackView.isHidden = false
        for (button, answer) in zip(singleButtons, answers) {
            button.setTitle(answer.text, for: .normal)
        }
    }
    
    private func showMultipleStackView(with answers: [Answer]) {
        multipleStackView.isHidden = false
        for (lable, answer) in zip(multipleLabels, answers) {
            lable.text = answer.text
        }
    }
    
    private func showRangedStackView(with answers: [Answer]) {
        rangedStackView.isHidden = false
        rangedLables.first?.text = answers.first?.text
        rangedLables.last?.text = answers.last?.text
    }
    
    private func nextQuestion() {
        questionIndex += 1
        if questionIndex < questions.count {
            updateUI()
            return
        }
        performSegue(withIdentifier: "showResults", sender: nil)
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let navigationVC = segue.destination as! UINavigationController
//        let resultVC = navigationVC.topViewController as! ResultViewController
        let resultVC = segue.destination as! ResultViewController
        resultVC.answers = answerChoosen

    }
}
