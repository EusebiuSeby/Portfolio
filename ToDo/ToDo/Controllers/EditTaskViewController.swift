//
//  EditTaskViewController.swift
//  ToDo
//
//  Created by Pudilic Seby on 20.03.2022.
//

import UIKit

var titluEdit = "mama"
var selected_colour = 1
var switchState = false

protocol EditViewControllerDelegate: NSObjectProtocol {
    func dataEditBack(textForTitle: String, colorTag: Int, switchDone: Bool)
}

class EditTaskViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var titleText: UITextField!
    @IBOutlet weak var color1: UIButton!
    @IBOutlet weak var color2: UIButton!
    @IBOutlet weak var color3: UIButton!
    @IBOutlet weak var color4: UIButton!
    @IBOutlet weak var switchCompletion: UISwitch!
    
    var whichColor = selected_colour
    
    weak var delegate: EditViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        titleText.text = titluEdit
        titleText.delegate = self
        switchCompletion.isOn = switchState
        switch (whichColor) {
        case 1: color1.isSelected = true
        case 2: color2.isSelected = true
        case 3: color3.isSelected = true
        case 4: color4.isSelected = true
        default: color1.isSelected = true
        }
    }
    
    @IBAction func applyPressed(_ sender: UIButton) {
        
        if let delegate = delegate {
            delegate.dataEditBack(textForTitle: titleText.text ?? "No title entered", colorTag: whichColor, switchDone: switchCompletion.isOn)
        }
        
        self.dismiss(animated: true, completion: nil)
        
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        titleText.endEditing(true)
        return true
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
