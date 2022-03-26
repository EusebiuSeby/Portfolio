//
//  CoinManager.swift
//  CryptoRates
//
//  Created by Pudilic Seby on 01.03.2022.
//

import Foundation

protocol CoinManagerDelegate {
    func didUpdatePrice(price: String)
    func didFailWithError(error: Error)
}

struct CoinManager {
    
    var delegate: CoinManagerDelegate?
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    let cryptoArray = ["BTC", "ETH", "EGLD", "USDT", "BNB", "ADA", "XRP", "SOL", "LUNA", "DOGE"]
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate"
    let apiKey = "6982B85F-C9BE-4E9C-AFF6-7B0C24F3F218"
    
    
    func getCoinPrice(crypto: String, currency: String) {
        let finalURL = "\(baseURL)/\(crypto)/\(currency)?apikey=\(apiKey)"
        
        if let url = URL(string: finalURL) {
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                
                if let safeData = data {
                    if let bitcoinPrice = self.parseJSON(safeData) {
                        let priceString = String(format: "%.2f", bitcoinPrice)
                        
                        self.delegate?.didUpdatePrice(price: priceString)
                    }
                }
                
            }
            
            task.resume()
        }
    }
    
    func parseJSON(_ data: Data) -> Double?{
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CoinData.self, from: data)
            let lastPrice = decodedData.rate
//            print(lastPrice)
            return lastPrice
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    
}
