//
//  CoinDetailDataService.swift
//  CryptoApp
//
//  Created by Subash Sethuraman A on 05/11/24.
//

import Foundation
import Combine

class CoinDetailDataService {
    @Published var coinDetail : CoinDetailModel? = nil
    let coin : CoinModel
    var coinSubscription : AnyCancellable?
    
    init(coin : CoinModel){
        self.coin = coin
        getCoinDetail()
    }
    
    
    private func getCoinDetail(){
        print(coin.id)
        guard let url = URL(string:"https://b16bc0da-0bc0-4e3a-8f59-7aa30481dbae.mock.pstmn.io/coinDetails") else {return}
        
        coinSubscription =  NetworkManager.download(url: url)
            .decode(type: CoinDetailModel.self, decoder: JSONDecoder())
            .sink { (completion) in
                NetworkManager.handleCompletion(completion: completion)
            } receiveValue: {[weak self] (returnedCoins) in
                self?.coinDetail = returnedCoins
                self?.coinSubscription?.cancel()
            }

            
    }
}
