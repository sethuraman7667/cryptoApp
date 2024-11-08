//
//  StatiticsSection.swift
//  CryptoApp
//
//  Created by Subash Sethuraman A on 02/11/24.
//

import SwiftUI

struct StatiticsSection: View {
    @State var isHomeScreen : Bool = true
    
    var body: some View {
        HStack() {
            threeRowSection
            Spacer()
            threeRowSection
            Spacer()
            threeRowSection
        }
        .frame( alignment: isHomeScreen ? .leading : .trailing)
        .padding()
    }
}

struct StatiticsSection_Previews: PreviewProvider {
    static var previews: some View {
        StatiticsSection()
            .previewLayout(.sizeThatFits)
    }
}

extension StatiticsSection{
    private var threeRowSection : some View {
        VStack{
            Text("Market Cap")
                .font(.caption)
                .foregroundColor(.theme.secondaryText)
            Text("$2323")
                .font(.subheadline)
                .foregroundColor(.theme.accent)
          
            if isHomeScreen {
                Label {
                    Text("1212")
                } icon: {
                    Image(systemName: "chevron.up")
                        .font(.subheadline)
                        .foregroundColor(.green)
                }
            }
            
        }
    }
}
