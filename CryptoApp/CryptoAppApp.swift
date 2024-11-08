//
//  CryptoAppApp.swift
//  CryptoApp
//
//  Created by Subash Sethuraman A on 01/11/24.
//

import SwiftUI

@main
struct CryptoAppApp: App {
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor : UIColor(Color.theme.accent)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor : UIColor(Color.theme.accent)]
    }
    
    @State var showLaunchScreen : Bool = true
    
    @StateObject private var vm = HomeViewModel()
    var body: some Scene {
        WindowGroup {
            ZStack{
            NavigationView {
                HomeView()
                    .navigationBarHidden(true)
            }
            .environmentObject(vm)
            
            ZStack{
                if showLaunchScreen {
                    CustomLaunch(showLaunchScreeen: $showLaunchScreen)
                    
                }
            }
            .zIndex(2.0)
        }
        }
    }
}
