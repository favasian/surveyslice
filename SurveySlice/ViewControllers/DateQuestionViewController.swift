//
//  BirthdayQuestionViewController.swift
//  SurveySlice
//
//  Created by Christopher Li on 6/22/18.
//  Copyright © 2018 Apps thay Pay. All rights reserved.
//

import UIKit

class DateQuestionViewController: TextInputViewController {
    
    var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(DateQuestionViewController.dateChanged(_:)), for: .valueChanged)
        self.inputField.inputView = datePicker
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(DateQuestionViewController.didTapMainScreen))
        self.innerView.addGestureRecognizer(tapRecognizer)
    }
    
    @objc func didTapMainScreen() {
        self.inputField.resignFirstResponder()
    }
    
    // need to override and do nothing since
    // CountryPickerDelegate handles it
    override func setSelectedAnswer(_ string: String?) {
    }
    
    @objc func dateChanged(_ sender: UIDatePicker) {
        let components = Calendar.current.dateComponents([.year, .month, .day], from: sender.date)
        if let day = components.day, let month = components.month, let year = components.year {
            self.selectedAnswers = ["\(sender.date.timeIntervalSince1970)"]
            print(self.selectedAnswers)
            self.inputField.text = "\(month)/\(day)/\(year)"
        }
    }
    
}
