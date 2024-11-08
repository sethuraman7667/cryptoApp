//
//  HomeRowView.swift
//  CryptoApp
//
//  Created by Subash Sethuraman A on 01/11/24.
//

import SwiftUI

struct HomeRowView: View {
    let coin : CoinModel
    let showHoldingColumn : Bool
    var body: some View {
        HStack(spacing : 0){
            leftColumn
            Spacer()
            if showHoldingColumn {
                centerColumn
            }
            rightColumn
        }
        .font(.subheadline)
        .padding(.zero)
    }
}

struct HomeRowView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            HomeRowView(coin: dev.coin, showHoldingColumn: true)
                .previewLayout(.sizeThatFits)
            HomeRowView(coin: dev.coin, showHoldingColumn: true)
                .previewLayout(.sizeThatFits)
                .preferredColorScheme(.dark)
        }
        
    }
}


extension HomeRowView {
    private var leftColumn : some View {
        HStack{
            Text("\(coin.rank)")
                .font(.caption)
                .foregroundColor(.theme.secondaryText)
                .frame(minWidth: 30)
            
            CoinImageView(coin: coin)
                .frame(width: 32, height: 32)
            Text("\(coin.symbol)".uppercased())
                .font(.headline)
                .padding(.leading, 6)
                .foregroundColor(.theme.accent)

        }
    }
    
    
    private var centerColumn : some View {
        VStack(alignment : .trailing){
            Text(coin.currentHoldingValues.asCurrencyWithDecimals())
                .bold()
            Text((coin.currentPrice ?? 0).asNumberString())
        }
        .foregroundColor(.theme.accent)
    }
    
    private var rightColumn : some View {
        
            VStack(alignment : .trailing){
                Text(coin.currentPrice.asCurrencyWithDecimals())
                    .bold()
                    .foregroundColor(.theme.accent)
                Text(coin.priceChangePercentage24H?.numberAddPercentage() ?? "")
                    .foregroundColor(
                        (coin.priceChangePercentage24H ?? 0) >= 0 ? .theme.green : .theme.red
                    )
            }
            .frame(width: UIScreen.main.bounds.width / 3)
        
    }
}
