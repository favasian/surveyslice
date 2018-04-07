//
//  SurveyViewController.swift
//  SurveySlice
//
//  Created by Christopher Li on 3/22/18.
//  Copyright © 2018 Apps thay Pay. All rights reserved.
//

import UIKit

protocol SurveyDelegate: class {
    func surveyCompleted(campaign: Campaign, survey: Survey)
}

class SurveyViewController: AlertViewController {

    
    var campaign: Campaign
    var survey: Survey
    var surveyQuestions: [Question]
    var currencyAmount: Int
    var currency: String
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
    
    init(campaign: Campaign, survey: Survey, questions: [Question]) {
        let currencyAmount = campaign.awardAmount()
        let currency = Globals.app.devApp!.currency

        self.campaign = campaign
        self.survey = survey
        
        self.currencyAmount = currencyAmount
        self.currency = currency
        self.surveyQuestions = questions
        
        super.init(title: "+\(currencyAmount) \(currency)", text: "Please complete the following \(questions.count) questions survey to earn \(currencyAmount) \(currency)", backNavBtnTitle: "Exit")
        self.alertViewDelegate = self
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startQuestion(questionNumber: Int=1) {
        var qvc:BaseQuestionViewController!
        let numberOfQuestions = surveyQuestions.count
        let qaObject = surveyQuestions[questionNumber-1]
        let q = qaObject.question
        let answers = qaObject.answers!.map { (answer) -> String in
            return answer.answer
        }
        let multiSelect = qaObject.multiSelect
        
        qvc = MultipleChoiceQuestionViewController(question: q, numberOfQuestions: numberOfQuestions, currentQuestionNumber: questionNumber, delgate: self, options: answers, multiSelect: multiSelect)
        Globals.mainVC.pushViewController(qvc, animated: true)
    }
    
    func finishSurvey() {
        let currencyAmount = self.currencyAmount
        let currency = self.currency
        let campaign = self.campaign
        let survey = self.survey
        Network.shared.createCompletion(campaign: self.campaign) { [weak self] (response, error) in
            if let _ = error {
                self?.displayAlert(title: "Oops", message: "An error occurred", completion: {
                    Globals.mainVC.popToRootViewController(animated: true)
                })
            } else {
                self?.surveyDelegate?.surveyCompleted(campaign: campaign, survey: survey)
                Globals.mainVC.popToRootViewController(animated: true)
                Globals.app.surveyCompleted(currencyAmount: currencyAmount, currency: currency)
            }
        }
        
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
            let vc = AlertViewController(title: nil, text: "You have completed your survey and earned \(self.currencyAmount) \(self.currency)", backNavBtnTitle: "Finish", btnTitle: "Finish")
            vc.alertViewDelegate = self
            Globals.mainVC.pushViewController(vc, animated: true)
        }
        
    }
}
