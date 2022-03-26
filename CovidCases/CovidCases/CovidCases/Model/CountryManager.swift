//
//  CountryData.swift
//  CovidCases
//
//  Created by Pudilic Seby on 10/02/2022.
//  Copyright © 2022 Pudililc Seby. All rights reserved.
//

import Foundation

protocol CountryManagerDelegate {
    func didUpdateCountry(country: String, population: Int)
    func didFailWithError(error: Error)
}

struct CountryManager {
    
    var delegate: CountryManagerDelegate?
    
    //    EXAMPLE URL: https://api.covid19api.com/total/country/romania
    let baseURL = "https://api.covid19api.com/total/country"
    func getCountryPop(for countryName: String) {
        var text2 = ""
        for ind in countryName {
            if ind == " " {
                text2 += "-"
            } else {
                text2 += String(ind)
            }
        }
        let urlString = "\(baseURL)/\(text2)"
        //        print(urlString)
        
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let totalPopulation = self.parseJSON(safeData) {
                        self.delegate?.didUpdateCountry(country: countryName, population: totalPopulation)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ data: Data) -> Int? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode([CountryData].self, from: data)
            
            let totalPop = decodedData.last?.Confirmed
            return totalPop
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
