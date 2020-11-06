//
//  CoinExchangeModel.swift
//  ByteCoin
//
//  Created by Johnson Olusegun on 11/5/20.
//

import Foundation

struct CoinExchangeModel{
    let time:String
    let asset_id_base:String
    let asset_id_quote:String
    let rate:Double
    
    // return the exchange rate in.1f
    var  currentRate:String {
        return String(format: "%.1f", rate)
    }

}
