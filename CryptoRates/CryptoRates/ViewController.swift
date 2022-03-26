//
//  ViewController.swift
//  CryptoRates
//
//  Created by Pudilic Seby on 01.03.2022.
//

import UIKit

var sCrypto = "BTC"
var sCurrency = "AUD"
var tog = false
var appereance = false

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, CoinManagerDelegate, DataEnteredDelegate {
    
    var selectedCrypto = "BTC"
    var selectedCurrency = "AUD"
    
    func userDidEnterInformation(crypto: String, currency: String) {
        coinManager.getCoinPrice(crypto: crypto, currency: currency)
    }
    
    
    @IBOutlet weak var themeButton: UIButton!
    @IBOutlet weak var cryptoLabel: UILabel!
    @IBOutlet weak var equalLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    
    var coinManager = CoinManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        coinManager.delegate = self
        
        cryptoLabel.text = ""
        equalLabel.text = ""
        currencyLabel.text = ""
        
        switch traitCollection.userInterfaceStyle {
        case .light: appereance = true
        default: appereance = false
        }
    }
    
    @IBAction func doneButton(_ sender: UIButton) {
        //        print(selectedCrypto)
        //        print(selectedCurrency)
        coinManager.getCoinPrice(crypto: selectedCrypto, currency: selectedCurrency)
        
    }
    
    //MARK: - Delegate de la Pair din urmatoru View Controller si segue pentru ca sa il accesam (vc2)
    
    @IBAction func popularPairsButton(_ sender: UIButton) {
        self.performSegue(withIdentifier: "mama", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mama" {
            let secondViewController = segue.destination as! PairsViewController
            secondViewController.delegate = self
        }
    }
    
    @IBAction func ChangeAppereance(_ sender: UIButton) {
        appereance = !appereance
        switch appereance {
        case true: overrideUserInterfaceStyle = .light
        default: overrideUserInterfaceStyle = .dark
        }
        
        if themeButton.currentImage == UIImage(systemName: "capsule.lefthalf.filled") {
            themeButton.setImage(UIImage(systemName: "capsule.righthalf.filled"), for: .normal)
        } else {
            themeButton.setImage(UIImage(systemName: "capsule.lefthalf.filled"), for: .normal)
        }
    }
    
    
    //MARK: - Coin Delegate
    
    func didUpdatePrice(price: String) {
        if tog == false {
            DispatchQueue.main.async {
                self.currencyLabel.text = "\(price) \(self.selectedCurrency)"
                self.equalLabel.text = "="
                self.cryptoLabel.text = "1 \(self.selectedCrypto)"
            }
        } else {
            DispatchQueue.main.async {
                self.currencyLabel.text = "\(price) \(sCurrency)"
                self.equalLabel.text = "="
                self.cryptoLabel.text = "1 \(sCrypto)"
            }
            tog = false
        }
        
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    
    
    //MARK: - PICKER
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 1 {
            return coinManager.cryptoArray.count
        } else {
            return coinManager.currencyArray.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 1 {
            return coinManager.cryptoArray[row]
        } else {
            return coinManager.currencyArray[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 1 {
            selectedCrypto = coinManager.cryptoArray[row]
        } else {
            selectedCurrency = coinManager.currencyArray[row]
        }
    }
    
    
}

