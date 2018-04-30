//
//  CountrySelectionViewController.swift
//  SurveySlice
//
//  Created by Christopher Li on 4/4/18.
//  Copyright © 2018 Apps thay Pay. All rights reserved.
//

import UIKit
import CountryPicker

class CountrySelectionViewController: TextInputViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let countryPicker = CountryPicker()
        countryPicker.countryPickerDelegate = self
        countryPicker.showPhoneNumbers = false
        self.inputField.inputView = countryPicker
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(CountrySelectionViewController.didTapMainScreen))
        self.innerView.addGestureRecognizer(tapRecognizer)
        
        let locale = Locale.current
        if let code = (locale as NSLocale).object(forKey: NSLocale.Key.countryCode) as? String {
            countryPicker.setCountry(code)
        }
    }
    
    @objc func didTapMainScreen() {
        self.inputField.resignFirstResponder()
    }
    
    // need to override and do nothing since
    // CountryPickerDelegate handles it
    override func setSelectedAnswer(_ string: String?) {
    }
}

extension CountrySelectionViewController: CountryPickerDelegate {
    func countryPhoneCodePicker(_ picker: CountryPicker, didSelectCountryWithName name: String, countryCode: String, phoneCode: String, flag: UIImage) {
        self.selectedAnswers = [countryCode, name]
        self.inputField.text = name
    }
}

