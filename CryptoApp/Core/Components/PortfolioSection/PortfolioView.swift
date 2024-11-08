//
//  PortfolioView.swift
//  CryptoApp
//
//  Created by Subash Sethuraman A on 03/11/24.
//

import SwiftUI

struct PortfolioView: View {
    @EnvironmentObject private var vm : HomeViewModel
    @State private var selectedCoin : CoinModel? = nil
    @State private var quantityText : String = ""
    @State private var showSaveBtn : Bool = false
    var body: some View {
        NavigationView{
            ScrollView{
                VStack{
                    SearchView(text: $vm.searchText)
                    hCoinList
                    
                    if(selectedCoin != nil){
                       selectedCoinView
                            .padding()
                    }
                    
                }
            }
            .navigationTitle("Edit Portfolio")
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading) {XmarkButtonView()}
                ToolbarItem(placement: .navigationBarTrailing) {
                    saveButtonView
                }
            })
            .onChange(of: vm.searchText) { newValue in
                if newValue == "" {
                    removeSelectedCoin()
                }
            }
            
        }
        
    }
}

struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView()
            .environmentObject(dev.homeVM)
    }
}

extension PortfolioView {
    private var hCoinList : some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack{
                ForEach(vm.allCoins){ coin in
                    CoinLogoView(coin: coin)
                        .padding()
                        .onTapGesture {
                            withAnimation(.easeIn) {
                                updateCoins(coins: coin)
                            }
                        }
                        .background(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(
                                selectedCoin?.id == coin.id ?
                                Color.theme.green : Color.clear, lineWidth: 2)
                        )
                    
                }
            }
        }
    }
    
    private func updateCoins(coins : CoinModel) {
        selectedCoin = coins
        if let portfolioCoin = vm.portfolioCoins.first(where: { $0.id == coins.id}){
            quantityText = "\(portfolioCoin.currentPrice)"
        } else {
            quantityText = ""
        }
    }
    
    private func quantityAndCurrentPrice() -> String {
        guard
            let quantity = Double(quantityText),
            let currPrice = selectedCoin?.currentPrice else {
            return "0"
        }
        return "\(quantity * currPrice)"
    }
    
    private var selectedCoinView : some View {
        VStack{
            HStack{
                Text("Current Price of \(selectedCoin?.symbol.uppercased() ?? "")")
                Spacer()
                Text("\(selectedCoin?.currentPrice ?? 0.0)")
            }
            Divider()
            HStack{
                Text("Enter Quantity you want buy:")
                Spacer()
                TextField("Ex 1.4", text: $quantityText)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
            }
            Divider()
            HStack{
                Text("Total price of : ")
                Spacer()
                Text(quantityAndCurrentPrice())
            }
        }
        .font(.headline)
        
    }
    
    
    private var saveButtonView : some View {
        Button {
            saveButtonPressed()
        } label: {
            HStack{
                Image(systemName: "checkmark")
                Text("SAVE")
            }
            .font(.headline)
        }
        .opacity((selectedCoin != nil && selectedCoin?.currentHoldingValues != Double(quantityText) ) ? 1.0 : 0.0 )
    }
    
    private func saveButtonPressed(){
        guard let coin = selectedCoin,
        let amount = Double(quantityText)
        else {return}
        
        
        vm.updatePortfolio(coin: coin, amount: amount)
        
        
        UIApplication.shared.endEditing()
        
        removeSelectedCoin()
        
    }
    
    private func removeSelectedCoin(){
        selectedCoin = nil
        quantityText = ""
    }
}
