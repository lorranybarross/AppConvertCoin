//
//  HistoryExchangeCardView.swift
//  AppConvertCoin
//
//  Created by Lorrany Barros on 05/04/24.
//

import SwiftUI

struct HistoryExchangeCardView: View {
    
    let coin: Coin
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            VStack(alignment: .leading) {
                Text(coin.name!)
                    .font(.headline)
                HStack {
                    Text(coin.code!)
                    Image(systemName: "arrow.right")
                    Text(coin.codein!)
                }
                .font(.footnote)
            }
            
            Divider()
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Buy")
                        .font(.footnote)
                    Text("\(coin.codein!) \(coin.buyValue)")
                }
                
                Spacer()
                
                VStack(alignment: .leading) {
                    Text("Sell")
                        .font(.footnote)
                    Text("\(coin.codein!) \(coin.sellValue)")
                }
                
                Spacer()
                
                Text("\(coin.percentageChange)%")
                    .foregroundStyle(coin.percentageChange.first == "-" ? .red : .accent)
            }
        }
    }
}

#Preview {
    HistoryExchangeCardView(coin: Coin.coinMock)
}
