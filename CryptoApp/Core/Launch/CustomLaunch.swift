//
//  CustomLaunch.swift
//  CryptoApp
//
//  Created by Subash Sethuraman A on 07/11/24.
//

import SwiftUI

struct CustomLaunch: View {
     var text : [String] = "Loading portfolio...".map{ String($0)}
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    @State var showLoadingText : Bool = false
    @State var counter : Int = 0
    @Binding var showLaunchScreeen : Bool
    @State var loop : Int = 0
    var body: some View {
        ZStack{
            Color.theme.background
                .ignoresSafeArea()
            
            Image("logo-transparent")
                .resizable()
                .frame(width: 100, height: 100)
            ZStack{
                if showLoadingText {
                    HStack(spacing : 0){
                    
                        ForEach(text.indices) { index in
                            Text(text[index])
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(.theme.accent)
                                .offset(y : counter == index ? -5 : 0)
                                
                        }
                    }
                   
                }
            }
            .offset(y : 72)
            
           
                
        }
        .onAppear{
            showLoadingText.toggle()
        }
        .onReceive(timer) { _ in
            withAnimation(.spring()) {
                counter += 1
                
                if(counter == text.count - 1){
                    counter = 0
                    loop += 3
                }
                if(loop > 3){
                    showLaunchScreeen = false
                }
            }
            
        }
    }
}

struct CustomLaunch_Previews: PreviewProvider {
    static var previews: some View {
        CustomLaunch(showLaunchScreeen : .constant(true))
            .preferredColorScheme(.dark)
    }
}
