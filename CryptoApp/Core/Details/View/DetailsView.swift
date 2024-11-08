//
//  DetailsView.swift
//  CryptoApp
//
//  Created by Subash Sethuraman A on 03/11/24.
//

import SwiftUI

struct DetailsView: View {
    @Binding var coin : CoinModel?
    @StateObject  var vm : DetailViewModel

    init(coin : Binding<CoinModel?>) {
        self._coin = coin
        _vm = StateObject(wrappedValue: DetailViewModel(coin: coin.wrappedValue!))
        print("initializing value : \(coin.wrappedValue?.name)")
    }
    
    var body: some View {
        ChartView(coin: coin!)
            .frame(minWidth: .zero, maxWidth: .infinity,  maxHeight: 300)
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView(coin: .constant(dev.coin))
            .preferredColorScheme(.dark)
    }
}
