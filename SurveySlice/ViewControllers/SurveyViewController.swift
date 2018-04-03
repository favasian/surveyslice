//
//  SurveyViewController.swift
//  SurveySlice
//
//  Created by Christopher Li on 3/22/18.
//  Copyright © 2018 Apps thay Pay. All rights reserved.
//

import UIKit

protocol SurveyDelegate: class {
    func surveyCompleted(_ campaign: [String:Any])
}

class SurveyViewController: AlertViewController {

    
    var campaign: [String:Any]!
    var surveyQuestions: [[String:Any]]!
    var currencyAmount: Int!
    var currency: String!
    var surveyDelegate: SurveyDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func cancel() {
        let alert = UIAlertController(title: "Are you sure you want to exit?", message: "You will not receive your reward!", preferredStyle: .alert)
        let dontExit = UIAlertAction(title: "Don't Exit", style: .default, handler: nil)
        alert.addAction(dontExit)
        let imSure = UIAlertAction(title: "I'm Sure", style: .destructive) { (alertAction) in
            Globals.mainVC.popToRootViewController(animated: true)
        }
        alert.addAction(imSure)
        self.present(alert, animated: true, completion: nil)
    }
    
    init(campaign: [String: Any]) {
        guard let currencyAmount = campaign["currencyAmount"] as? Int else { fatalError("currency amount does not exist") }
        guard let currency = campaign["currency"] as? String else { fatalError("currency does not exist") }
        guard let avgTime = campaign["avgTime"] as? Int else { fatalError("avgTime does not exist") }
        let sqs = Globals.dummySurveyQuestions()

        super.init(title: "+\(currencyAmount) \(currency)", text: "Please complete the following \(sqs.count) questions survey to earn \(currencyAmount) \(currency)", backNavBtnTitle: "Exit")
        
        self.campaign = campaign
        self.alertViewDelegate = self
        self.currencyAmount = currencyAmount
        self.currency = currency
        self.surveyQuestions = sqs
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startQuestion(questionNumber: Int=1) {
        var qvc:BaseQuestionViewController!
        let numberOfQuestions = surveyQuestions.count
        let qaObject = surveyQuestions[questionNumber-1]
        let q = qaObject["question"] as! String
        let answers = qaObject["options"] as! [String]
        let multiSelect = qaObject["multi"] as! Bool
        //let qType = qaObject["type"] as! QuestionType
        
        qvc = MultipleChoiceQuestionViewController(question: q, numberOfQuestions: numberOfQuestions, currentQuestionNumber: questionNumber, delgate: self, options: answers, multiSelect: multiSelect)
        Globals.mainVC.pushViewController(qvc, animated: true)
    }
    
    func finishSurvey() {
        self.surveyDelegate?.surveyCompleted(self.campaign)
        Globals.mainVC.popToRootViewController(animated: true)
        Globals.app.surveyCompleted(currencyAmount: self.currencyAmount, currency: self.currency)
    }
}

extension SurveyViewController: AlertViewDelegate {
    func backNavBtnTapped(_ alertViewController: AlertViewController) {
        if self == alertViewController {
            self.cancel()
        } else {
            self.finishSurvey()
        }
    }
    
    func bottomBtnTapped(_ alertViewController: AlertViewController) {
        if self == alertViewController {
            self.startQuestion()
        } else {
            self.finishSurvey()
        }
    }
}

extension SurveyViewController: QuestionViewDelegate {
    func submittedAnswers(answers: [String], questionNumber: Int) {
        print(answers.joined(separator: ","))
        
        let questionIndex = questionNumber - 1
        if self.surveyQuestions.count >= questionNumber + 1 {
            self.startQuestion(questionNumber: questionNumber+1)
        } else {
            let vc = AlertViewController(title: nil, text: "You have completed your survey and earned \(self.currencyAmount!) \(self.currency!)", backNavBtnTitle: "Finish", btnTitle: "Finish")
            vc.alertViewDelegate = self
            Globals.mainVC.pushViewController(vc, animated: true)
        }
        
    }
}
