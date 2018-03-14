//
//  BaseQuestionViewController.swift
//  SurveySlice
//
//  Created by Christopher Li on 3/9/18.
//  Copyright © 2018 Apps thay Pay. All rights reserved.
//

import UIKit

protocol QuestionViewDelegate: class {
    func nextQuestion()
}

class BaseQuestionViewController: BottomButtonableViewController {
    
    var progressBar: ProgressBar!
    var questionLabel: UILabel!
    
    var question: String!
    var questionNumber: Int!
    var totalNumberOfQuestions: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Question \(questionNumber!+1)"
        setupProgressBar()
        setupQuestionLabel()
        self.bottomBtn.setTitle("Next", for: .normal)
    }
    
    func setupProgressBar() {
        self.progressBar = ProgressBar.newProgressBar(steps: totalNumberOfQuestions, currentStep: questionNumber)
        self.view.addSubview(self.progressBar)
        self.progressBar.translatesAutoresizingMaskIntoConstraints = false
        self.progressBar.topAnchor.constraint(equalTo: self.view.topAnchor, constant: Globals.padding).isActive = true
        self.progressBar.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
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
        
        self.view.addSubview(self.questionLabel)
        self.questionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.questionLabel.topAnchor.constraint(equalTo: self.progressBar.bottomAnchor, constant: Globals.padding).isActive = true
        self.questionLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        let widthConstraint = NSLayoutConstraint(item: self.questionLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: Globals.progressBarSize.width)
        let heightConstraint = NSLayoutConstraint(item: self.progressBar, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: Globals.progressBarSize.height)
        self.view.addConstraints([widthConstraint, heightConstraint])
    }
}
