//
//  HistoryExchangeView.swift
//  AppConvertCoin
//
//  Created by Lorrany Barros on 05/04/24.
//

import SwiftUI

struct HistoryExchangeView: View {
    
    let viewModel = HomeViewModel(service: WebService())
    
    @State private var coinsList = [Coin]()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(coinsList.reversed(), id: \.name) { coin in
                    HistoryExchangeCardView(coin: coin)
                }
                .listRowSeparator(.visible)
                .listRowSeparatorTint(.accent)
            }
            .navigationTitle("History Exchanges")
            .toolbar {
                ToolbarItem {
                    Button("Delete All", role: .destructive) {
                        viewModel.deleteHistoryExchange()
                        coinsList = []
                    }
                    .tint(.red)
                }
            }
            .onAppear {
                coinsList = viewModel.getHistoryExchange()
            }
        }
    }
}

#Preview {
    HistoryExchangeView()
}
