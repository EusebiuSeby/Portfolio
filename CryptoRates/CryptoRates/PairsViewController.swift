//
//  PairsViewController.swift
//  CryptoRates
//
//  Created by Pudilic Seby on 01.03.2022.
//

import UIKit

protocol DataEnteredDelegate: AnyObject {
    func userDidEnterInformation(crypto: String, currency: String)
}

class PairsViewController: UIViewController {
    
    var delegate: DataEnteredDelegate? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tog = true
        switch appereance {
        case true: overrideUserInterfaceStyle = .light
        default: overrideUserInterfaceStyle = .dark
        }
    }
    
    @IBAction func button(_ sender: UIButton!) {
        if sender.currentTitle == "BTC / USD" {
            sCrypto = "BTC"
            sCurrency = "USD"
        } else if sender.currentTitle == "BNB / EUR" {
            sCrypto = "BNB"
            sCurrency = "EUR"
        } else if sender.currentTitle == "DOGE / USD" {
            sCrypto = "DOGE"
            sCurrency = "USD"
        } else if sender.currentTitle == "EGLD / RON" {
            sCrypto = "EGLD"
            sCurrency = "RON"
        } else if sender.currentTitle == "EGLD / USD" {
            sCrypto = "EGLD"
            sCurrency = "USD"
        } else {
            sCrypto = "XRP"
            sCurrency = "EUR"
        }
        
        delegate?.userDidEnterInformation(crypto: sCrypto, currency: sCurrency)
        self.dismiss(animated: true, completion: nil)
    }
    
}

