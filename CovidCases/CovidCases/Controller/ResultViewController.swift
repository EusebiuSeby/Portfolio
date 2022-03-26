//
//  ResultViewController.swift
//  CovidCases
//
//  Created by Pudilic Seby on 08/02/2022.
//  Copyright © 2022 Pudililc Seby. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    @IBOutlet weak var numberCases: UILabel!
    @IBOutlet weak var countryName: UILabel!
    @IBOutlet weak var outlet1: UILabel!
    @IBOutlet weak var outlet3: UILabel!
    
    
    var countryManager = CountryManager()
    var cazuri = ""
    var nume = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        countryManager.delegate = self
        countryManager.getCountryPop(for: text1)
        countryName.text = " "
        numberCases.text = " "
        outlet3.text = " "
        outlet1.text = " "
    }
    
    func formatNumber(_ n: String) -> String {
        let cn = String(n.reversed())
        var cnt = 3
        var n1 = ""
        for i in cn {
            n1 += String(i)
            cnt -= 1
            if cnt == 0 {
                n1 += "."
                cnt = 3
            }
        }
        if n1.last == "." {
            n1 = String(n1.dropLast())
        }
        n1 = String(n1.reversed())
        return n1
    }
    
}

extension ResultViewController: CountryManagerDelegate {
    func didUpdateCountry(country: String, population: Int) {
        DispatchQueue.main.async {
            self.countryName.text = country
            self.numberCases.text = self.formatNumber(String(population))
            //            self.numberCases.text = String(population)
            self.outlet3.text = "cases in"
            self.outlet1.text = "There are"
        }
    }
    
    func didFailWithError(error: Error) {
        DispatchQueue.main.async {
            print(error)
            self.outlet1.text = "Error"
            self.numberCases.text = ""
            self.outlet3.text = "Country not"
            self.countryName.text = "found"
        }
        
    }
}

