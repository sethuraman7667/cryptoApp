//
//  ChartView.swift
//  CryptoApp
//
//  Created by Subash Sethuraman A on 06/11/24.
//

import SwiftUI

struct ChartView: View {
    let coin : CoinModel
    private var data : [Double] = []
    private let minY : Double
    private let maxY : Double
    private let heightOfYAxis : Double
    private let lineColor : Color
    @State var chatNumberIncreasing : Double = 0
    
    
    init(coin : CoinModel){
        self.coin = coin
        self.data = coin.sparkLing7DData ?? []
        minY = data.min() ?? 0
        maxY = data.max() ?? 0
        heightOfYAxis = maxY - minY
        lineColor = heightOfYAxis > 0 ? Color.theme.green : Color.theme.red
    }
    var body: some View {
        mainChart
            .background(
                VStack{
                    Divider()
                    Spacer()
                    Divider()
                    Spacer()
                    Divider()
                }
            )
            .overlay(
                VStack(){
                    Text("\(maxY)")
                    Spacer()
                    Text("\((maxY + minY) / 2)")
                    Spacer()
                    Text("\(minY)")
                }
                    .font(.caption)
                    .foregroundColor(.theme.secondaryText)
                ,
                alignment: .leading
            )
            .frame( height: 300)
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView(coin: dev.coin)
    }
}

extension ChartView {
    private var mainChart : some View {
        GeometryReader{ geomentry in
            Path { path in
                for index in data.indices{
                    
                    let xPosition = (geomentry.size.width / CGFloat(data.count)) * CGFloat(index + 1)
                    
                    let yPosition = (1 - CGFloat((data[index] - minY) / heightOfYAxis)) * geomentry.size.height
                    if index == 0 {
                        path.move(to: CGPoint(x: xPosition, y: yPosition))
                    }
                    path.addLine(to: CGPoint(x: xPosition, y: yPosition))
                }
            }
            .trim(from: 0, to: chatNumberIncreasing)
            .stroke(lineColor, style: StrokeStyle(lineWidth: 1, lineCap: .round, lineJoin: .round))
        }
        .onAppear{
            withAnimation(.linear(duration: 3), {
                chatNumberIncreasing = 1.0
            })
        }
    }
}


