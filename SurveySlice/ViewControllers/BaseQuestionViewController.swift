//
//  BaseQuestionViewController.swift
//  SurveySlice
//
//  Created by Christopher Li on 3/9/18.
//  Copyright © 2018 Apps thay Pay. All rights reserved.
//

import UIKit

protocol QuestionViewDelegate: class {
    func submittedAnswers(answers: [String]?, questionNumber: Int)
}

class BaseQuestionViewController: BottomButtonableViewController {
    
    var questionDelegate: QuestionViewDelegate?
    var progressBar: ProgressBar!
    var questionLabel: UILabel!
    
    var question: String!
    var questionNumber: Int!
    var totalNumberOfQuestions: Int!
    var selectedAnswers: [String]?
    
    init(question: String, numberOfQuestions: Int, currentQuestionNumber: Int, delgate: QuestionViewDelegate) {
        self.question = question
        self.totalNumberOfQuestions = numberOfQuestions
        self.questionNumber = currentQuestionNumber
        self.questionDelegate = delgate
        super.init(nibName: nil, bundle: nil)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Question \(questionNumber!)"
        setupProgressBar()
        setupQuestionLabel()
        self.bottomBtn.setTitle("Next", for: .normal)
        self.bottomBtnDelegate = self
    }
    
    func setupProgressBar() {
        self.progressBar = ProgressBar.newProgressBar(steps: totalNumberOfQuestions, currentStep: questionNumber)
        self.addSubview(self.progressBar)
        self.progressBar.translatesAutoresizingMaskIntoConstraints = false
        self.progressBar.topAnchor.constraint(equalTo: self.innerView.topAnchor, constant: Globals.smallPadding).isActive = true
        self.progressBar.centerXAnchor.constraint(equalTo: self.innerView.centerXAnchor).isActive = true
        
        let widthConstraint = NSLayoutConstraint(item: self.progressBar, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: Globals.progressBarSize.width)
        let heightConstraint = NSLayoutConstraint(item: self.progressBar, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: Globals.progressBarSize.height)
        self.view.addConstraints([widthConstraint, heightConstraint])
    }
    
    func setupQuestionLabel() {
        self.questionLabel = UILabel()
        self.questionLabel.font = Globals.appFont()
        self.questionLabel.textAlignment = .center
        self.questionLabel.textColor = Globals.grayFont
        self.questionLabel.text = question
        self.questionLabel.numberOfLines = 0
        self.questionLabel.adjustsFontSizeToFitWidth = true
        
        self.addSubview(self.questionLabel)
        self.questionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.questionLabel.topAnchor.constraint(equalTo: self.progressBar.bottomAnchor, constant: Globals.smallPadding).isActive = true
        self.questionLabel.centerXAnchor.constraint(equalTo: self.innerView.centerXAnchor).isActive = true
        
        let widthConstraint = NSLayoutConstraint(item: self.questionLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: Globals.questionLabelSize.width)
        let heightConstraint = NSLayoutConstraint(item: self.questionLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: Globals.questionLabelSize.height)
        self.view.addConstraints([widthConstraint, heightConstraint])
    }
    
    func isValidSelectedAnswers() -> Bool {
        return self.selectedAnswers != nil && !self.selectedAnswers!.isEmpty
    }
    
    //Method to allow clean up after user has tried to submit an invalid option
    func cleanupAfterInvalidAnswer() {
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

extension BaseQuestionViewController: BottomButtonDelegate {
    func buttonTapped() {
        if self.isValidSelectedAnswers() {
            self.questionDelegate?.submittedAnswers(answers: self.selectedAnswers, questionNumber: self.questionNumber)
        } else {
            self.displayAlert(title: "Oops", message: "Invalid option", completion: {
                self.cleanupAfterInvalidAnswer()
            })
        }
    }
}
