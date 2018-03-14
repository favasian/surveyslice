//
//  AgeQuestionViewController.swift
//  SurveySlice
//
//  Created by Christopher Li on 3/14/18.
//  Copyright © 2018 Apps thay Pay. All rights reserved.
//

import UIKit

class AgeQuestionViewController: TextInputViewController {

    override func viewDidLoad() {
        self.keyboardType = UIKeyboardType.numbersAndPunctuation
        self.question = "What is your age?"
        super.viewDidLoad()
        
    }

    override func isValidSelectedAnswers() -> Bool {
        if super.isValidSelectedAnswers() {
            guard let answer = self.selectedAnswers?.first else { return false }
            guard let age = Int(answer) else { return false }
            return answer == "\(age)"
        }
        return false
    }
}
