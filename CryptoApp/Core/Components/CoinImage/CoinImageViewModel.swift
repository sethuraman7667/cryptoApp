//
//  CoinImageViewModel.swift
//  CryptoApp
//
//  Created by Subash Sethuraman A on 02/11/24.
//

import Foundation
import SwiftUI
import Combine

class CoinImageViewModel : ObservableObject {
    @Published var image : UIImage? = nil
    @Published var isLoading : Bool = false
    
    private let coin : CoinModel
    private let dataService : CoinImageService
    private var cancellable = Set<AnyCancellable>()
    
    init(coin : CoinModel) {
        self.coin = coin
        dataService = CoinImageService(coin: coin)
        self.isLoading = true
        getImage()
    }
    
    private func getImage(){
        dataService.$image
            .sink { [weak self] (_) in
                self?.isLoading = false
            } receiveValue: { [weak self] (returnedImage) in
                self?.image = returnedImage
            }
            .store(in: &cancellable)
    }
}
