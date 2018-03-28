//
//  InitialProfiler.swift
//  SurveySlice
//
//  Created by Christopher Li on 3/1/18.
//  Copyright © 2018 Apps thay Pay. All rights reserved.
//

import UIKit

class InitialProfiler: AlertViewController {

    var submittedAnswers:[[String]?] = []
    
    public override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    public override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func cancel() {
        Globals.mainVC.dismiss()
    }
    
    init(displayIncorrectAnswerAlert: Bool=false) {
        if displayIncorrectAnswerAlert {
            super.init(title: "Oops", text: "You didn't take enough time to complete this Initial Survey", backNavBtnTitle: "Exit", btnTitle: "Start Over")
        } else {
            super.init(title: "Survey Slice", text: "Please complete the following 11 questions survey to earn 200 coins", backNavBtnTitle: "Exit")
        }
        
        self.alertViewDelegate = self
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startQuestion(questionNumber: Int=1) {
        var qvc:BaseQuestionViewController!
        let numberOfQuestions = Globals.intialProfilerQAs().count
        let qaObject = Globals.intialProfilerQAs()[questionNumber-1]
        let q = qaObject["question"] as! String
        let answers = qaObject["options"] as! [String]
        let multiSelect = qaObject["multi"] as! Bool
        let qType = qaObject["type"] as! QuestionType
        let validations = qaObject["validations"] as? [AnswerValidation: Any]
        
        switch qType {
        case .gender:
            qvc = GenderQuestionViewController(numberOfQuestions: numberOfQuestions, currentQuestionNumber: questionNumber, delgate: self)
        case .number:
            qvc = NumberInputViewController(question: q, numberOfQuestions: numberOfQuestions, currentQuestionNumber: questionNumber, delgate: self, validations: validations)
        case .multipleChoice:
            qvc = MultipleChoiceQuestionViewController(question: q, numberOfQuestions: numberOfQuestions, currentQuestionNumber: questionNumber, delgate: self, options: answers, multiSelect: multiSelect)
        default:
            print("default")
        }
        Globals.mainVC.pushViewController(qvc, animated: true)
    }
    
    func areSubmittedAnswersCorrect() -> Bool {
        var index = 0
        for qaObject in Globals.intialProfilerQAs() {
            if let correctAnswers = qaObject["correctAnswers"] as? [String] {
                for answer in correctAnswers {
                    if !self.submittedAnswers.indices.contains(index) { return false }
                    guard let submittedAnswers = self.submittedAnswers[index] else { return false }
                    if !submittedAnswers.contains(answer) { return false }
                }
            }
            index += 1
        }
        return true
    }
    
    func displayIncorrectAnswerAlert() {
        let vc = InitialProfiler(displayIncorrectAnswerAlert: true)
        Globals.mainVC.viewControllers = [vc]
    }
}

extension InitialProfiler: AlertViewDelegate {
    func backNavBtnTapped(_ alertViewController: AlertViewController) {
        self.cancel()
    }
    
    func bottomBtnTapped(_ alertViewController: AlertViewController) {
        self.startQuestion()
    }
}

extension InitialProfiler: QuestionViewDelegate {
    func submittedAnswers(answers: [String]?, questionNumber: Int) {
        if let answers = answers { print(answers.joined(separator: ",")) }
        
        let questionIndex = questionNumber - 1
        if submittedAnswers.indices.contains(questionIndex) {
            submittedAnswers[questionIndex] = answers
        } else {
            submittedAnswers.append(answers)
        }
        if Globals.intialProfilerQAs().count >= questionNumber + 1 {
            self.startQuestion(questionNumber: questionNumber+1)
        } else if self.areSubmittedAnswersCorrect() {
            self.cancel()
        } else {
           self.displayIncorrectAnswerAlert()
        }
        
    }
}
