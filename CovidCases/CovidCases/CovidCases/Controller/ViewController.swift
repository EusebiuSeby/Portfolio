//
//  ViewController.swift
//  CovidCases
//
//  Created by Pudilic Seby on 08/02/2022.
//  Copyright © 2022 Pudililc Seby. All rights reserved.
//

import UIKit

var text1: String = ""
class ViewController: UIViewController {
    
    var countryManager = CountryManager()
    var countryName: String = ""
    var countryCases: Int = 0
    
    @IBOutlet weak var countryTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countryTextField.delegate = self
        
    }
    
    @IBAction func searchPressed(_ sender: UIButton) {
        if let text = countryTextField.text {
//            for ind in text {
//                if ind == " " {
//                    text1 += "-"
//                } else {
//                    text1 += String(ind)
//                }
//            }
            text1 = text
        }
        countryTextField.text = ""
        self.performSegue(withIdentifier: "mama", sender: self)
    }
}

//MARK: - UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
//        print(countryTextField.text ?? "no input")
        countryTextField.endEditing(true)
        
        return true
    }
}



