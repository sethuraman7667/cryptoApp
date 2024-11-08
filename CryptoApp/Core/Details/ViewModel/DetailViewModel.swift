//
//  DetailViewModel.swift
//  CryptoApp
//
//  Created by Subash Sethuraman A on 05/11/24.
//

import Foundation
import Combine

class DetailViewModel : ObservableObject{
    
    @Published var coinDetails : CoinDetailModel? = nil
 
    private let dataService = CoinDataService()
    private let coinDataService : CoinDetailDataService?
    private var cancellable = Set<AnyCancellable>()
    
    init(coin : CoinModel){
        coinDataService = CoinDetailDataService(coin: coin)
        addSubscribers()
    }
    
    
    func addSubscribers(){
        
        
        coinDataService?.$coinDetail
            .sink(receiveValue: { [weak self] returnedCoinDetail in
                self?.coinDetails = returnedCoinDetail
                print(returnedCoinDetail)
            })
            .store(in: &cancellable)
        
    }
}
