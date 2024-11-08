//
//  CoinDetailModel.swift
//  CryptoApp
//
//  Created by Subash Sethuraman A on 05/11/24.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let mainUnits = try? JSONDecoder().decode(MainUnits.self, from: jsonData)

import Foundation

// MARK: - MainUnits
struct CoinDetailModel :  Codable {
    
    let id, symbol, name, webSlug: String
    let blockTimeInMinutes: Int?
    let categories: [String]?
    let previewListing: Bool?
    let marketData: MarketData?
    let description: Tion?
    let image: Images?
    
    enum CodingKeys : String, CodingKey {
        case id, symbol, name
        case webSlug = "web_slug"
        case blockTimeInMinutes = "block_time_in_minutes"
        case categories
        case previewListing = "preview_listing"
        case marketData = "market_data"
        case description
        case image
    }
    
    
    
    
}


// MARK: - Tion
struct Tion : Codable {
    let en, de: String?
    
    enum CodingKeys : String, CodingKey {
        case en, de
    }
}



// MARK: - Image
struct Images : Codable {
    let thumb, small, large: String?
    
    enum CodingKeys : String, CodingKey {
        case thumb, small, large
    }
}


// MARK: - MarketData
struct MarketData : Codable {
    let currentPrice: [String: Double]?
//    let ath, athChangePercentage: [String: Double]?
//    let athDate: [String: String]?
//    let atl, atlChangePercentage: [String: Double]?
//    let atlDate: [String: String]?
//    let marketCap: [String: Double]?
//    let marketCapRank: Int?
//    let fullyDilutedValuation: [String: Double]?
//    let marketCapFdvRatio: Double?
//    let totalVolume, high24H, low24H: [String: Double]?
//    let priceChange24H: Int?
   
    let priceChangePercentage24HInCurrency: [String: Double]?
    let priceChangePercentage30DInCurrency: [String: Double]?
  
   
    
    enum CodingKeys : String, CodingKey {
        case currentPrice = "current_price"
        case priceChangePercentage24HInCurrency = "price_change_percentage_24h_in_currency"
        case priceChangePercentage30DInCurrency = "price_change_percentage_30d_in_currency"
        
    }
}





