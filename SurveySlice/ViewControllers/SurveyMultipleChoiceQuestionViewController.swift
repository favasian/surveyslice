//
//  SurveyMultipleChoiceQuestionViewController.swift
//  SurveySlice
//
//  Created by Christopher Li on 4/7/18.
//  Copyright © 2018 Apps thay Pay. All rights reserved.
//

import UIKit

class SurveyMultipleChoiceQuestionViewController: MultipleChoiceQuestionViewController {

    var answerOptions: [Answer]
    
    init(question: String, numberOfQuestions: Int, currentQuestionNumber: Int, delgate: QuestionViewDelegate, answerOptions: [Answer], multiSelect: Bool) {
        self.answerOptions = answerOptions
        let stringAnswerOptions = answerOptions.map { (answer) -> String in
            return answer.answer
        }
        super.init(question: question, numberOfQuestions: numberOfQuestions, currentQuestionNumber: currentQuestionNumber, delgate: delgate, options: stringAnswerOptions, multiSelect: multiSelect)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupAnswerOptions() {
        var lastOption:UIButton? = nil
        for answer in self.answerOptions {
            let btn = UIButton()
            btn.tag = answer.id // override to add id tag
            self.addSubview(btn)
            btn.setBackgroundImage(answerOptionImage, for: .normal)
            btn.setBackgroundImage(selectedOptionImage, for: .highlighted)
            btn.translatesAutoresizingMaskIntoConstraints = false
            
            btn.centerXAnchor.constraint(equalTo: self.innerView.centerXAnchor).isActive = true
            
            let widthConstraint = NSLayoutConstraint(item: btn, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: Globals.answerOptionSize.width)
            let heightConstraint = NSLayoutConstraint(item: btn, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: Globals.answerOptionSize.height)
            self.innerView.addConstraints([widthConstraint, heightConstraint])
            if let lo = lastOption {
                btn.topAnchor.constraint(equalTo: lo.bottomAnchor, constant: Globals.smallPadding).isActive = true
            } else {
                btn.topAnchor.constraint(equalTo: self.questionLabel.bottomAnchor, constant: Globals.padding).isActive = true
            }
            
            btn.contentMode = .scaleAspectFill
            btn.titleLabel?.font = Globals.heavyAppfont(size: 14)
            btn.titleLabel?.numberOfLines = 2
            btn.titleLabel?.textColor = UIColor.white
            btn.setTitle(answer.answer, for: .normal)
            btn.contentHorizontalAlignment = .left
            btn.titleLabel?.adjustsFontSizeToFitWidth = true
            btn.contentEdgeInsets = Globals.answerOptionInset
            
            btn.addTarget(self, action: #selector(MultipleChoiceQuestionViewController.optionTapped(_:)), for: .touchUpInside)
            answerButtons.append(btn)
            lastOption = btn
        }
        self.contentMayExceedViewHeight(lastOption)
    }
    
    override func setSelectedAnswersFromMultipleChoice() {
        self.selectedAnswers = []
        for btn in answerButtons {
            if btn.backgroundImage(for: .normal) == selectedOptionImage {
                self.selectedAnswers.append("\(btn.tag)")
            }
        }
        if self.selectedAnswers.isEmpty { self.selectedAnswers = [] }
    }
}
