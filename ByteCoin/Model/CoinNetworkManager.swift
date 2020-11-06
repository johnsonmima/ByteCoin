//
//  CoinNetworkManager.swift
//  ByteCoin
//
//  Created by Johnson Olusegun on 11/1/20.
//

import Foundation

//CoinNetworkManagerDelegate
protocol CoinNetworkManagerDelegate {
    
    // didFailWithError
    func didFailWithError(_ error:Error)
    // didGetResult
    func didGetResult(_ result:CoinExchangeModel)
}



struct CoinNetworkManager{
    // delegate
    var delegate:CoinNetworkManagerDelegate?
    
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    
    func setExchangeRate(with currencyIndex:Int){
        
        // get the api key
        guard let apiKey = ProcessInfo.processInfo.environment["apiKey"] else { return }
        // url string
        let urlString = "\(baseURL)/\(currencyArray[currencyIndex])?apiKey=\(apiKey)"
        
        // get the exchange rate
        getExchangeRate(with: urlString)
        
    }
    
    // perform the request
    func getExchangeRate(with url:String){
        // url
        guard let url = URL(string: url) else { return }
        
        //urlSession
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                delegate?.didFailWithError(error!)
            }
            
            if let myData = data {
                
                //check if coin manager is nil
                if  let coniManager = decodeResponse(with: myData)  {
                    delegate?.didGetResult(coniManager)
                }
                
            }
            
        }
        task.resume()
        
        
        
    }
    
    // decode the data from JSON
    func decodeResponse(with data:Data) -> CoinExchangeModel?{
        do {
            let json = try JSONDecoder().decode(CoinExchangeData.self, from: data)
            let time = json.time
            let asset_id_base = json.asset_id_base
            let asset_id_quote = json.asset_id_quote
            let rate = json.rate
            
            return CoinExchangeModel(time: time, asset_id_base: asset_id_base, asset_id_quote: asset_id_quote, rate: rate)
            
        } catch let error as NSError {
            delegate?.didFailWithError(error)
            return nil
        }
    }
    
}
