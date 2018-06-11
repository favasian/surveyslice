//
//  PreScreenViewController.swift
//  SurveySlice
//
//  Created by Christopher Li on 6/11/18.
//  Copyright © 2018 Apps thay Pay. All rights reserved.
//

import UIKit

protocol PreScreenDelegate: class {
    func preScreenFinishedSuccessfully(survey: Survey, campaign: Campaign)
}

class PreScreenViewController: InitialProfiler {

    var survey: Survey
    var campaign: Campaign
    var preScreenQuestions: [Question]
    
    var preScreenDelegate: PreScreenDelegate?
    
    init(survey: Survey, campaign: Campaign, displayIncorrectAnswerAlert: Bool = false) {
        self.survey = survey
        self.campaign = campaign
        guard let qs = survey.preScreenQuestions else { fatalError("Survey has no pre screen questions") }
        self.preScreenQuestions = qs
        
        if displayIncorrectAnswerAlert {
            super.init(title: "Oops", text: "You didn't answer the Pre Screening Questions Correctly in order to Continue to the Survey", backNavBtnTitle: "Back", btnTitle: "Start Over")
        } else {
            super.init(title: "Survey Slice", text: "Please correctly answer the following Pre Screening Questions to continue to the Survey", backNavBtnTitle: nil)
        }
        
        self.alertViewDelegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func finishedSuccessfully() {
        Globals.mainVC.popToRootViewController(animated: false)
        self.preScreenDelegate?.preScreenFinishedSuccessfully(survey: self.survey, campaign: self.campaign)
    }
    
    override func cancel() {
        Globals.mainVC.popToRootViewController(animated: true)
    }
    
    override func startQuestion(questionNumber: Int=1) {
        let numberOfQuestions = self.preScreenQuestions.count
        let qaObject = self.preScreenQuestions[questionNumber-1]
        let q = qaObject.question
        let answers = qaObject.answerStringArray()
        let multiSelect = qaObject.multiSelect
        
        let qvc = MultipleChoiceQuestionViewController(question: q, numberOfQuestions: numberOfQuestions, currentQuestionNumber: questionNumber, delgate: self, options: answers, multiSelect: multiSelect)
        Globals.mainVC.pushViewController(qvc, animated: true)
    }
    
    override func areSubmittedAnswersCorrect() -> Bool {
        var index = 0
        for qaObject in self.preScreenQuestions {
            let correctAnswers = qaObject.correctAnswerStringArray()
            for answer in correctAnswers {
                if !self.submittedAnswers.indices.contains(index) { return false }
                let submittedAnswers = self.submittedAnswers[index] //else { return false }
                if !submittedAnswers.contains(answer) { return false }
            }
            index += 1
        }
        return true
    }
    
    override func displayIncorrectAnswerAlert() {
        let vc = PreScreenViewController(survey: survey, campaign: campaign, displayIncorrectAnswerAlert: true)
        vc.preScreenDelegate = self.preScreenDelegate
        Globals.mainVC.popToRootViewController(animated: false)
        Globals.mainVC.pushViewController(vc, animated: false)
    }
    
    override func submittedAnswers(answers: [String], questionNumber: Int) {
        let questionIndex = questionNumber - 1
        if submittedAnswers.indices.contains(questionIndex) {
            submittedAnswers[questionIndex] = answers
        } else {
            submittedAnswers.append(answers)
        }
        if self.preScreenQuestions.count >= questionNumber + 1 {
            self.startQuestion(questionNumber: questionNumber+1)
        } else if self.areSubmittedAnswersCorrect() {
            self.finishedSuccessfully()
        } else {
            self.displayIncorrectAnswerAlert()
        }
        
    }
}
