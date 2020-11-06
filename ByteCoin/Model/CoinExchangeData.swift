//
//  CoinExchangeData.swift
//  ByteCoin
//
//  Created by Johnson Olusegun on 11/5/20.
//

import Foundation

struct CoinExchangeData:Codable {
    let time:String
    let asset_id_base:String
    let asset_id_quote:String
    let rate:Double

}




