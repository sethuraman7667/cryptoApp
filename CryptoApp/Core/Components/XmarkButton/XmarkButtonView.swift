//
//  XmarkButtonView.swift
//  CryptoApp
//
//  Created by Subash Sethuraman A on 03/11/24.
//

import SwiftUI

struct XmarkButtonView: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "xmark")
        }
    }
}

struct XmarkButtonView_Previews: PreviewProvider {
    static var previews: some View {
        XmarkButtonView()
    }
}
