//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Adm Aidyn on 10/19/22.
//

import UIKit

protocol CoinManagerDelegate {
    func didUpdateCurrency(_ coinManager: CoinManager, currencyRate: CoinModel)
    
    func didFailWithError(error: Error)
}

struct CoinManager {
    
    let baseURL = Constants.baseURL
    let apiKey = Constants.apiKey
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    
    var delegate: CoinManagerDelegate?
    
    func getCoinPrice(for currency: String) {
        let finalUrl = "\(baseURL)/\(currency)/?apikey=\(apiKey)"
        performRequest(with: finalUrl)
        print(finalUrl)
    }
    
    
    func performRequest(with urlString: String) {
        //1.Create an URL
        if let url = URL(string: urlString) {
            
            //2.create URLSession
            let session = URLSession(configuration: .default)
            
            //3. Give session a task
            let task = session.dataTask(with: url) { (data, urlResponse, error) in
    
                // check for nill value
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                //Print "data" from inputs -> (data: safeData, encoding: .utf8)
                if let safeData = data {
                    if let coin = parseJSON(safeData) {
                        self.delegate?.didUpdateCurrency(self, currencyRate: coin)
                        let str = String(decoding: safeData, as: UTF8.self)
                        print(str)
                    }
                }
            }
            //4.Start the task
            task.resume()
        }
    }
    
    //this function decodes json file into a readible swift file
    func parseJSON(_ data: Data) -> CoinModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CoinData.self, from: data)
            
            let lastPrice = decodedData.rate
            
            let coin = CoinModel(currencyRate: lastPrice)
            
            return coin
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
