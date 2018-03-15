//
//  AgeQuestionViewController.swift
//  SurveySlice
//
//  Created by Christopher Li on 3/14/18.
//  Copyright © 2018 Apps thay Pay. All rights reserved.
//

import UIKit

class AgeQuestionViewController: TextInputViewController {

    init(numberOfQuestions: Int, currentQuestionNumber: Int, delgate: QuestionViewDelegate) {
        super.init(question: "What is your age?", numberOfQuestions: numberOfQuestions, currentQuestionNumber: currentQuestionNumber, delgate: delgate)
    }
    
    override func viewDidLoad() {
        self.keyboardType = UIKeyboardType.numbersAndPunctuation
        super.viewDidLoad()
    }

    override func isValidSelectedAnswers() -> Bool {
        if !super.isValidSelectedAnswers() { return false }
        guard let answer = self.selectedAnswers?.first else { return false }
        guard let age = Int(answer) else { return false }
        return answer == "\(age)"
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
