//
//  PreviewProvider.swift
//  CryptoApp
//
//  Created by Subash Sethuraman A on 01/11/24.
//

import Foundation
import SwiftUI

extension PreviewProvider{
    static var dev: DeveloperPreview{
        return DeveloperPreview.instance
    }
}

class DeveloperPreview {
    static let instance = DeveloperPreview()
    private init() {}
    
    let homeVM = HomeViewModel()
    
    let coin = CoinModel(
        id: "bitcoin",
        symbol: "btc",
        name: "Bitcoin",
        image: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1696501400",
        currentPrice: 70187,
        marketCap: 1381651251183,
        marketCapRank: 1,
        fullyDilutedValuation: 1474623675796,
        totalVolume: 20154184933,
        high24H: 70215,
        low24H: 68060,
        priceChange24H: 2126.88,
        priceChangePercentage24H: 3.12502,
        marketCapChange24H: 44287678051,
        marketCapChangePercentage24H: 3.31157,
        circulatingSupply: 19675987,
        totalSupply: 21000000,
        maxSupply: 21000000,
        ath: 73738,
        athChangePercentage: -4.77063,
        athDate: "2024-03-14T07:10:36.635Z",
        atl: 67.81,
        atlChangePercentage: 103455.83335,
        atlDate: "2013-07-06T00:00:00.000Z",
        lastUpdated: "2024-04-07T16:49:31.736Z",
        sparkLing7DData : [152.94, 155.81, 157.18, 158.04, 157.1, 157.78, 157.48, 157.12, 155.81, 157.12, 156.57, 156.46, 157.45,
            157.69, 159.05, 158.77, 159.84, 160.21, 160.91, 159.97, 160.62, 160.27, 158.5, 157.12, 158.61, 159.92,
            159.12, 159.36, 160.7, 160.63, 159.84, 161.72, 160.17, 159.45, 158.54, 157.57, 156.71, 156.57, 158.31
        ]

    )
}
