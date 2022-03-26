//
//  TaskViewController.swift
//  ToDo
//
//  Created by Pudilic Seby on 16.03.2022.
//

import UIKit

protocol DisplayViewControllerDelegate: NSObjectProtocol {
    func dataBack(textForTitle: String, colorTag: Int)
}

class TaskViewController: UIViewController {
    
    @IBOutlet weak var titleText: UITextField!
    @IBOutlet weak var color1: UIButton!
    @IBOutlet weak var color2: UIButton!
    @IBOutlet weak var color3: UIButton!
    @IBOutlet weak var color4: UIButton!
    
    var whichColor = 1
    
    weak var delegate: DisplayViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        titleText.delegate = self
        color1.isSelected = true
    }
    
    @IBAction func applyPressed(_ sender: UIButton) {
        
        if let delegate = delegate {
            delegate.dataBack(textForTitle: titleText.text ?? "No title entered", colorTag: whichColor)
        }
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func colorPressed(_ sender: UIButton) {
        color1.isSelected = false
        color2.isSelected = false
        color3.isSelected = false
        color4.isSelected = false
        sender.isSelected = true
        whichColor = sender.tag
        
    }
    
}

extension TaskViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        titleText.endEditing(true)
        return true
    }
}
