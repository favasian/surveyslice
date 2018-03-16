//
//  TextInputViewController.swift
//  SurveySlice
//
//  Created by Christopher Li on 3/14/18.
//  Copyright © 2018 Apps thay Pay. All rights reserved.
//

import UIKit

class TextInputViewController: BaseQuestionViewController {

    var inputField: UITextField!
    var keyboardType: UIKeyboardType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInputField()
        inputField.becomeFirstResponder()
    }
    
    func setupInputField() {
        inputField = UITextField()
        inputField.translatesAutoresizingMaskIntoConstraints = false
        inputField.font = Globals.appFont()
        inputField.autocorrectionType = .no
        inputField.delegate = self
        inputField.textAlignment = .center
        inputField.keyboardType = keyboardType
        self.addSubview(inputField)
        
        inputField.topAnchor.constraint(equalTo: self.questionLabel.bottomAnchor, constant: 0).isActive = true
        inputField.centerXAnchor.constraint(equalTo: self.innerView.centerXAnchor).isActive = true
        
        let widthConstraint = NSLayoutConstraint(item: inputField, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: Globals.inputFieldSize.width)
        let heightConstraint = NSLayoutConstraint(item: inputField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: Globals.inputFieldSize.height)
        self.view.addConstraints([widthConstraint, heightConstraint])
    }
    
    override func isValidSelectedAnswers() -> Bool {
        if !super.isValidSelectedAnswers() { return false }
        guard let answer = self.selectedAnswers?.first else { return false }
        return !answer.isEmpty
    }
    
    override func cleanupAfterInvalidAnswer() {
        self.inputField.becomeFirstResponder()
    }
    
    func setSelectedAnswer(_ string: String?) {
        if let text = string {
            self.selectedAnswers = [text]
        } else {
            self.selectedAnswers = nil
        }
    }
}

extension TextInputViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("ended")
        self.setSelectedAnswer(textField.text)
    }
}
