//
//  BirthdayQuestionViewController.swift
//  SurveySlice
//
//  Created by Christopher Li on 6/22/18.
//  Copyright © 2018 Apps thay Pay. All rights reserved.
//

import UIKit

class BirthdayQuestionViewController: DateQuestionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.datePicker.minimumDate = Calendar.current.date(byAdding: .year, value: -150, to: Date())
        self.datePicker.maximumDate = Date()
    }
}
