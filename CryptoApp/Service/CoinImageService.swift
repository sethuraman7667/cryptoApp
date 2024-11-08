//
//  CoinImageService.swift
//  CryptoApp
//
//  Created by Subash Sethuraman A on 02/11/24.
//

import Foundation
import SwiftUI
import Combine

class CoinImageService{
    @Published var image : UIImage? = nil
    var imageSubscription : AnyCancellable?
    
    
   private let coin : CoinModel
   private let imageName : String
   private let folderName : String = "coinImages"
    
    private let fileManager = LocalFileManager.instance
    
    init(coin : CoinModel){
        self.coin = coin
        self.imageName = coin.id
        getCoins()
    }
    
    private func getCoins(){
        if let saveImage = fileManager.getImage(imageName: imageName, folderName: folderName){
            image = saveImage
            print("retrieving image successfully!!!")
        } else {
            downLoadCoinImages(urlString: coin.image)
            print("saved Successfullyy!!!")
        }
    }
    
    private func downLoadCoinImages(urlString : String){
        guard let url = URL(string: urlString) else {return}
        
        imageSubscription =  NetworkManager.download(url: url)
            .tryMap({ (data) -> UIImage? in
                return UIImage(data: data)
            })
            .sink { (completion) in
                NetworkManager.handleCompletion(completion: completion)
            } receiveValue: {[weak self] (returnedCoins) in
                guard
                    let self = self,
                   let downloadImage = returnedCoins else { return }
                self.image = downloadImage
                self.imageSubscription?.cancel()
                self.fileManager.saveImage(image: downloadImage, imageName: self.imageName, folderName: self.folderName)
            }

            
    }
}
