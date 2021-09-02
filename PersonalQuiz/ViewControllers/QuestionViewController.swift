//
//  QuestionViewController.swift
//  PersonalQuiz
//
//  Created by Tatiana Dmitrieva on 21/07/2021.
//

import UIKit

class QuestionViewController: UIViewController {
    
    
    @IBOutlet weak var questionProgressView: UIProgressView!
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var singleStackView: UIStackView!
    
    @IBOutlet var singleButtons: [UIButton]!
    
    @IBOutlet weak var multipleStackView: UIStackView!
    @IBOutlet var multipleLabels: [UILabel]!
    @IBOutlet var multipleSwitches: [UISwitch]!
    
    @IBOutlet weak var rangeStackView: UIStackView!
    @IBOutlet var rangeLabels: [UILabel]!
    @IBOutlet weak var rangeSlider: UISlider! {
        didSet {
            let answerCount = Float(currentAnswers.count - 1)
            rangeSlider.value = answerCount / 2
            rangeSlider.maximumValue = answerCount
        }
    }
    
    private let questions = Question.getQuestions()
    private var questionIndex = 0
    private var currentAnswers: [Answer] { // вычисляемое св-во на основе только что объявленных свойств
        questions[questionIndex].answers
    }
    private var answerChooser: [Answer] = [] // массив для запоминания выбора пользователя
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vc = segue.destination as? ResultsViewController else {return}
        vc.answerChoosen = answerChooser
    }
    
    @IBAction func singleAnswerButtonPressed(_ sender: UIButton) {
        guard let buttonIndex = singleButtons.firstIndex(of: sender) else { return } // определяем индекс нажатой пользователем кнопки с //помощью метода firstIndex(of: sender) - это первый попавшийся индекс кнопки на кот нажал пользователь
        let currentAnswer = currentAnswers[buttonIndex]
        answerChooser.append(currentAnswer) // ответ по  найденному индексу добавляем в массив
        nextQuestion()
    }
    
    @IBAction func multipleAnswerButtonPressed() {
        for (multipleSwitch, answer) in zip(multipleSwitches, currentAnswers) {
            if multipleSwitch.isOn {
                answerChooser.append(answer)
            }
        }
       nextQuestion()
    }
    
    @IBAction func rangeAnswerButtonPressed(_ sender: Any) {
        let index = lrintf(rangeSlider.value) // функцией lrintf приводим значение Float k Int
        answerChooser.append(currentAnswers[index])
        nextQuestion()
    }
}

extension QuestionViewController {
    
    private func setupUI() {
        for stackView in [singleStackView, multipleStackView, rangeStackView] {
            stackView?.isHidden = true
        }
        
        let currentQuestion = questions[questionIndex]
        questionLabel.text = currentQuestion.title
        
        let totalProgress = Float(questionIndex) / Float(questions.count)
        questionProgressView.setProgress(totalProgress, animated: true)
        
        title = "Вопрос № \(questionIndex + 1) из \(questions.count)"
        
        showCurrentAnswers(for: currentQuestion.type)
    }
    
    private func showCurrentAnswers(for type: ResponseType) {
        switch type {
        
        case .single: showSingleStackView(with: currentAnswers)
        case .multiple: showMultipleStackView(with: currentAnswers)
        case .ranged: showRangeStackView(with: currentAnswers)
        }
    }
    
    private func showSingleStackView(with answers: [Answer]) {
        singleStackView.isHidden = false
        for (button, answer) in zip(singleButtons, answers) {
            button.setTitle(answer.title, for: .normal)
        }
    }
    
    private func showMultipleStackView(with answers: [Answer]) {
        multipleStackView.isHidden = false
        
        for (label, answer) in zip(multipleLabels, answers) {
            label.text = answer.title
        }
    }
    
    private func showRangeStackView(with answers: [Answer]) {
        rangeStackView.isHidden = false
        rangeLabels.first?.text = answers.first?.title
        rangeLabels.last?.text = answers.last?.title
    }
    
    private func nextQuestion() {
        questionIndex += 1
        if questionIndex < questions.count {
            setupUI()
            return
        }
        performSegue(withIdentifier: "showResult", sender: nil)
    }
}
