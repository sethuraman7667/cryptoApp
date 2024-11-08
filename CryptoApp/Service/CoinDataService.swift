//
//  CoinDataService.swift
//  CryptoApp
//
//  Created by Subash Sethuraman A on 02/11/24.
//

import Foundation
import Combine

class CoinDataService {
    @Published var allCoins : [CoinModel] = []
    var coinSubscription : AnyCancellable?
    
    init(){
        getCoins()
    }
    
    
    private func getCoins(){
        guard let url = URL(string:"https://b16bc0da-0bc0-4e3a-8f59-7aa30481dbae.mock.pstmn.io/coinList") else {return}
        
        coinSubscription =  NetworkManager.download(url: url)
            .decode(type: [CoinModel].self, decoder: JSONDecoder())
            .sink { (completion) in
                NetworkManager.handleCompletion(completion: completion)
            } receiveValue: {[weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
                self?.coinSubscription?.cancel()
            }

            
    }
}
