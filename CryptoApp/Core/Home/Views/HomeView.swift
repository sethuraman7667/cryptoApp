//
//  HomeView.swift
//  CryptoApp
//
//  Created by Subash Sethuraman A on 01/11/24.
//

import SwiftUI

struct HomeView: View {
    @State private var showPortfolio : Bool = false
    @State private var showPortfolioSheet : Bool = false
    @EnvironmentObject private var vm : HomeViewModel
    
    @State var showDetailsView : Bool = false
    @State var selectedCoin : CoinModel? = nil
    
    var body: some View {
        ZStack{
            Color.theme.background
                .ignoresSafeArea()
                .sheet(isPresented: $showPortfolioSheet) {
                    PortfolioView()
                        .environmentObject(vm)
                }
            
            VStack{
                HeaderView
                showPortfolio ?
                StatiticsSection(isHomeScreen: true)
                : StatiticsSection(isHomeScreen: false)
                SearchView(text: $vm.searchText)
                titleForRow
                
                if !showPortfolio {
                    withouHolding
                    .transition(.move(edge: .leading))
                    
                    
                }
                
                if showPortfolio {
                   withHoldings
                    .transition(.move(edge: .trailing))
                }
                
                Spacer()
            }
        }
        .background(
            NavigationLink(isActive: $showDetailsView, destination: {
                DetailsView(coin: $selectedCoin)
            }, label: {
                EmptyView()
            }))
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            HomeView()
                .navigationBarHidden(true)
        }
        .preferredColorScheme(.dark)
        .environmentObject(dev.homeVM)
        
    }
}

extension HomeView {
    
    private func createSegue(coin : CoinModel){
        selectedCoin = coin
        showDetailsView.toggle()
    }
    
    
    private var HeaderView : some View {
        HStack{
            CircleButtonView(iconName: showPortfolio ? "plus" : "info")
                .animation(.none)
                .onTapGesture {
                    if showPortfolio {
                        showPortfolioSheet.toggle()
                    }
                }
                .background(
                    CircleButtonAnimation(animate: $showPortfolio))
            
            Spacer()
            Text(showPortfolio ? "Portfolio" : "Live Prices")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundColor(.theme.accent)
                .animation(.none)
            Spacer()
            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring()){
                        showPortfolio.toggle()
                    }
                }
        }
        .padding(.horizontal, 12)
    }
    
    private var titleForRow : some View {
        HStack{
            Text("Coin")
                .onTapGesture {
                    print("coin")
                    vm.sortingOption = vm.sortingOption == .rank ? .rankReversed : .rank
                }
            Spacer()
            if showPortfolio {
                Text("Holding")
            }
            Text("Price")
                .frame(width: UIScreen.main.bounds.width / 4)
            Button {
                print("button pressed")
                vm.addSubcribers()
            } label: {
                Image(systemName: "arrow.clockwise")
            }

        }
        .font(.caption)
        .foregroundColor(.theme.secondaryText)
        .padding()
    }

    private var withouHolding : some View{
        List {
            ForEach(vm.allCoins){ coin in
                    HomeRowView(coin: coin, showHoldingColumn: false)
                        .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 0))
                        .onTapGesture {
                            createSegue(coin: coin)
                        }
              
            }
        }
        .listStyle(PlainListStyle())
    }
    
    private var withHoldings : some View {
        List {
            ForEach(vm.portfolioCoins){ coin in
                HomeRowView(coin: coin, showHoldingColumn: true)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 0))
                
            }
        }
        .listStyle(PlainListStyle())
    }
    
}

