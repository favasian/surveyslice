//
//  AgeQuestionViewController.swift
//  SurveySlice
//
//  Created by Christopher Li on 3/14/18.
//  Copyright © 2018 Apps thay Pay. All rights reserved.
//

import UIKit

class NumberInputViewController: TextInputViewController {
    
    override func viewDidLoad() {
        self.keyboardType = UIKeyboardType.numbersAndPunctuation
        super.viewDidLoad()
    }

    override func isValidSelectedAnswers() -> Bool {
        if !super.isValidSelectedAnswers() { return false }
        guard let answer = self.selectedAnswers?.first else { return false }
        return CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: answer))
    }
}
