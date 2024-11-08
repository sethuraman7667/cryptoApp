//
//  HomeViewModel.swift
//  CryptoApp
//
//  Created by Subash Sethuraman A on 02/11/24.
//

import Foundation
import Combine
import SwiftUI

class HomeViewModel : ObservableObject {
    
    @Published var allCoins : [CoinModel] = []
    @Published var portfolioCoins : [CoinModel] = []
    @Published var searchText : String = ""
    @Published var sortingOption : SortOption = .rank
    
    
    private let dataService = CoinDataService()
    private let portfolioDataService = PortfolioDataService()
    private var cancellable = Set<AnyCancellable>()
    
    
    
    enum SortOption {
        case rank, rankReversed, holding, holdingsReversed, price , PriceReversed
    }
    
    init() {
        addSubcribers()
    }
    
    func addSubcribers(){
//        dataService.$allCoins
//            .sink { [weak self] (returnedCoins) in
//                self?.allCoins = returnedCoins
//            }
//            .store(in: &cancellable)
        
        $searchText
            .combineLatest(dataService.$allCoins, $sortingOption)
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .map(filterAndSortingCoins)
            .sink { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellable)
     
        
            $allCoins
            .combineLatest(portfolioDataService.$savedEntities)
            .map { (coinModels, portfolioEntities) -> [CoinModel] in
                coinModels
                    .compactMap { (coin) -> CoinModel? in
                        guard let entity = portfolioEntities.first(where: { $0.coinID == coin.id }) else {
                            return nil
                        }
                        return coin.updateHoldings(amount: entity.amount)
                    }
            }
            .sink { [weak self] (returnedCoins) in
                self?.portfolioCoins = returnedCoins
            }
            .store(in: &cancellable)
        
    }
    
    func updatePortfolio(coin : CoinModel, amount : Double){
        portfolioDataService.updatePortfolio(coin: coin, amount: amount)
        
    }
    
    private func filterAndSortingCoins(text : String, startingCoins : [CoinModel], sorting : SortOption) -> [CoinModel]{
        
        var filteredCoins = filterCoins(text: text, startingCoins: startingCoins)
         sortCoins(sort: sorting, coins: &filteredCoins)
        return filteredCoins
    }
    
    
    private func sortCoins(sort : SortOption, coins : inout [CoinModel]){
        switch sort{
        case .rank:
             coins.sort(by: { $0.rank < $1.rank })
        case .rankReversed:
             coins.sort(by: { $0.rank > $1.rank })
        case .holding:
              coins.sort(by: { $0.currentHoldingValues < $1.currentHoldingValues })
        case .holdingsReversed:
              coins.sort(by: { $0.currentHoldingValues > $1.currentHoldingValues })
        case .price:
              coins.sort(by: { $0.currentPrice < $1.currentPrice })
        case .PriceReversed:
              coins.sort(by: { $0.currentPrice > $1.currentPrice })
        }
    }
    
    
    private func filterCoins(text : String, startingCoins : [CoinModel]) -> [CoinModel]{
        guard !text.isEmpty else {
            return startingCoins
        }
        
        let loweredCaseLetter = text.lowercased()
        return startingCoins.filter { (coin) in
            return coin.name.lowercased().contains(loweredCaseLetter) ||
            coin.id.lowercased().contains(loweredCaseLetter) ||
            coin.symbol.lowercased().contains(loweredCaseLetter)
        }
    }
}
