//
//  SearchView.swift
//  CryptoApp
//
//  Created by Subash Sethuraman A on 02/11/24.
//

import SwiftUI

struct SearchView: View {
    @Binding var text : String
    var body: some View {
        HStack{
            Image(systemName: "magnifyingglass")
            TextField("search coin or symbol...", text: $text)
                .foregroundColor(.theme.accent)
                .overlay(
                Image(systemName: "xmark.circle.fill")
                    .padding()
                    .foregroundColor(.theme.accent)
                    .opacity(text.isEmpty ? 0.0 : 1.0)
                    .onTapGesture {
                        UIApplication.shared.endEditing()
                        text = ""
                    }
                ,alignment: .trailing
                )
        }
        .font(.headline)
        .padding()
        .background(
        RoundedRectangle(cornerRadius: 25)
            .fill(Color.theme.background)
            .shadow(color: .theme.accent.opacity(0.1), radius: 10, x: 0, y: 0)
        )
        .padding()
        
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(text: .constant(""))
            .preferredColorScheme(.dark)
    }
}
