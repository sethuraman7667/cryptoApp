//
//  ContentView.swift
//  CryptoApp
//
//  Created by Subash Sethuraman A on 01/11/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack{
            Color.theme.background
                .ignoresSafeArea()
            
            VStack(spacing : 20){
                Text("Accent Color")
                    .foregroundColor(Color.theme.accent)
                Text("Secondary Text Color")
                    .foregroundColor(.theme.secondaryText)
                Text("Red Color")
                    .foregroundColor(.theme.red)
                Text("Green Color")
                    .foregroundColor(.theme.green)
            }
            .font(.subheadline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
