//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Sergey Zakurakin on 22/06/2024.
//

import Foundation

protocol CoinManagerDelegate {
    func didUpdateCoint(price: String)
}

struct CoinManager {
    
    var delegate: CoinManagerDelegate?
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate"
    let apiKey = "EAD13E24-D012-4744-8B47-13C22E4303C4"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    func getCoinPrice(for currency: String) {
        let urlString = "\(baseURL)/\(currency)/USD?apikey=\(apiKey)"
        performRequest(with: urlString)
    }
    
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    //                    delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    //                    print(String(data: safeData, encoding: .utf8))
                    //                    let str = String.init(data: deviceToken, encoding: .utf8)
                    //                    let dataString = String(data: safeData, encoding: .utf8)
                    //                    print(dataString)
                    if let coinPrice = parseJSON(safeData) {
                        let priceString = String(format: "%.2f", coinPrice)
                        self.delegate?.didUpdateCoint(price: priceString)
                        
                    }
                }
            }
            task.resume()
        }
        
    }
        
        func parseJSON(_ coinData: Data) -> Double? {
            
            let decoder = JSONDecoder()
            
            do {
                let decodedData = try decoder.decode(CoinData.self, from: coinData)
                let lastPrice = decodedData.rate
                
//                let coin = CoinModel(coinRate: coinRate)
                
                //                print(weather.cityName)
                //                print(weather.conditionName)
                //                print(weather.temperatureString)
                return lastPrice
                
                
            } catch {
                return nil
                
            }
        }
    }




