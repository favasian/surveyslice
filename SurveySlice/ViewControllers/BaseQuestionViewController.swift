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
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
