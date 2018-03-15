//
//  MultipleChoiceQuestionViewController.swift
//  SurveySlice
//
//  Created by Christopher Li on 3/14/18.
//  Copyright © 2018 Apps thay Pay. All rights reserved.
//

import UIKit

class MultipleChoiceQuestionViewController: BaseQuestionViewController {

    var options: [String]!
    var multiSelect: Bool!
    
    var answerOptionImage: UIImage!
    var rejectedOptionImage: UIImage!
    var selectedOptionImage: UIImage!
    
    init(question: String, numberOfQuestions: Int, currentQuestionNumber: Int, delgate: QuestionViewDelegate, options: [String], multiSelect: Bool) {
        self.options = options
        self.multiSelect = multiSelect
        
        guard let answerOption = UIImage(named: "answerOption", in: Globals.appBundle(), compatibleWith: nil)  else { fatalError("No answerOption Image") }
        guard let answerOptionSelected = UIImage(named: "answerOptionSelected", in: Globals.appBundle(), compatibleWith: nil)  else { fatalError("No answerOptionSelected Image") }
        guard let answerOptionRejected = UIImage(named: "answerOptionRejected", in: Globals.appBundle(), compatibleWith: nil)  else { fatalError("No answerOptionRejected Image") }
        self.answerOptionImage = answerOption
        self.rejectedOptionImage = answerOptionRejected
        self.selectedOptionImage = answerOptionSelected
        super.init(question: question, numberOfQuestions: numberOfQuestions, currentQuestionNumber: currentQuestionNumber, delgate: delgate)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupAnswerOptions()
    }
    
    func setupAnswerOptions() {
        var lastOption:UIButton? = nil
        for option in self.options {
            let btn = UIButton()
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
            
            btn.titleLabel?.font = Globals.appFont()
            btn.titleLabel?.textColor = UIColor.white
            btn.setTitle(option, for: .normal)
            btn.contentHorizontalAlignment = .left
            btn.titleLabel?.adjustsFontSizeToFitWidth = true
            btn.contentEdgeInsets = UIEdgeInsetsMake(-5, 80, 0, 0)
            lastOption = btn
        }
        self.contentMayExceedViewHeight(lastOption)
    }
}
