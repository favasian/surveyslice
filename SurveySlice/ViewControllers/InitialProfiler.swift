//
//  InitialProfiler.swift
//  SurveySlice
//
//  Created by Christopher Li on 3/1/18.
//  Copyright © 2018 Apps thay Pay. All rights reserved.
//

import UIKit

public class InitialProfiler: UINavigationController {

    var submittedAnswers:[[String]?] = []
    
    public override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    public override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    @objc private func cancel() {
        self.dismiss(animated: true) {
        }
    }
    
    public class func instantiate() -> InitialProfiler {
        let nav = InitialProfiler(nibName: "InitialProfiler", bundle: Globals.appBundle())
        nav.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white, .font: Globals.appFont(size: 20)]
        if let navImage = UIImage(named: "navigation", in: Globals.appBundle(), compatibleWith: nil) {
            nav.navigationBar.setBackgroundImage(navImage.resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: .stretch), for: .default)
        }
        let vc = AlertViewController.instantiate(title: "Survey Slice", text: "Please complete the following 11 question survey to earn 200 coins", backNavBtnTitle: "Exit")
        vc.alertViewDelegate = nav
        nav.viewControllers = [vc]
        return nav
    }
    
    private func startQuestion(questionNumber: Int=1) {
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
        self.pushViewController(qvc, animated: true)
    }
    
    private func areSubmittedAnswersCorrect() -> Bool {
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
    
    private func displayIncorrectAnswerAlert() {
        self.submittedAnswers.removeAll()
        let vc = AlertViewController.instantiate(title: "Oops", text: "You didn't take enough time to complete this Initial Survey", backNavBtnTitle: "Exit", btnTitle: "Start Over")
        vc.alertViewDelegate = self
        self.viewControllers = [vc]
    }
}

extension InitialProfiler: AlertViewDelegate {
    func backNavBtnTapped() {
        self.cancel()
    }
    
    func bottomBtnTapped() {
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
