//
//  InitialProfiler.swift
//  SurveySlice
//
//  Created by Christopher Li on 3/1/18.
//  Copyright © 2018 Apps thay Pay. All rights reserved.
//

import UIKit
import SwiftSpinner

class InitialProfiler: AlertViewController {

    var submittedAnswers:[[String]] = []
    
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
            super.init(title: "Survey Slice", text: "Please first complete the following \(Demographic.intialProfilerQAs().count) questions survey", backNavBtnTitle: "Exit")
        }
        
        self.alertViewDelegate = self
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createSurveyeeWithAnswers() {
        SwiftSpinner.show("Finishing Up Survey")
        Surveyee.createFromInitialProfilerAnswers(self.submittedAnswers) { (surveyee) in
            SwiftSpinner.hide()
            guard let surveyee = surveyee else {
                self.displayAlert(title: "Oops", message: "An error occurred", completion: {
                    
                })
                return
            }
            Globals.app.surveyee = surveyee
            Globals.mainVC.showSurveyWall()
        }
    }
    
    func startQuestion(questionNumber: Int=1) {
        var qvc:BaseQuestionViewController!
        let numberOfQuestions = Demographic.intialProfilerQAs().count
        let qaObject = Demographic.intialProfilerQAs()[questionNumber-1]
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
        case .text:
            let tivc = TextInputViewController(question: q, numberOfQuestions: numberOfQuestions, currentQuestionNumber: questionNumber, delgate: self, validations: validations)
            tivc.keyboardType = .numbersAndPunctuation
            qvc = tivc
        case .multipleChoice:
            qvc = MultipleChoiceQuestionViewController(question: q, numberOfQuestions: numberOfQuestions, currentQuestionNumber: questionNumber, delgate: self, options: answers, multiSelect: multiSelect)
        case .country:
            qvc = CountrySelectionViewController(question: q, numberOfQuestions: numberOfQuestions, currentQuestionNumber: questionNumber, delgate: self)
        default:
            print("default")
        }
        Globals.mainVC.pushViewController(qvc, animated: true)
    }
    
    func areSubmittedAnswersCorrect() -> Bool {
        var index = 0
        for qaObject in Demographic.intialProfilerQAs() {
            if let correctAnswers = qaObject["correctAnswers"] as? [String] {
                for answer in correctAnswers {
                    if !self.submittedAnswers.indices.contains(index) { return false }
                    let submittedAnswers = self.submittedAnswers[index] //else { return false }
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
    func submittedAnswers(answers: [String], questionNumber: Int) {
        print(answers.joined(separator: ","))
        
        let questionIndex = questionNumber - 1
        if submittedAnswers.indices.contains(questionIndex) {
            submittedAnswers[questionIndex] = answers
        } else {
            submittedAnswers.append(answers)
        }
        if Demographic.intialProfilerQAs().count >= questionNumber + 1 {
            self.startQuestion(questionNumber: questionNumber+1)
        } else if self.areSubmittedAnswersCorrect() {
            self.createSurveyeeWithAnswers()
        } else {
           self.displayIncorrectAnswerAlert()
        }
        
    }
}
