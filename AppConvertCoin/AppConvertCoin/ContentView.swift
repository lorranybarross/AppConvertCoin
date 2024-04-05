//
//  ContentView.swift
//  AppConvertCoin
//
//  Created by Lorrany Barros on 04/04/24.
//

import SwiftUI

struct ContentView: View {
    
    let viewModel = HomeViewModel(service: WebService())
    
    @State private var coinTypes = [String]()
    @State private var coins: [Coin] = []
    @State private var value: String = ""
    @State private var convertedValue: String = ""
    @State private var selectedCoinFrom: String = "USD"
    @State private var selectedCoinTo: String = "EUR"
    
    func getCoins() async {
        do {
            let endpoint = "\(selectedCoinFrom)-\(selectedCoinTo)"
            guard let response = try await viewModel.getCoins(endpoint: endpoint) else {
                return
            }
            self.coins = response
        } catch {
            print("Error to load coins: \(error.localizedDescription)")
        }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 30) {
                    Divider()
                    
                    VStack(alignment: .leading) {
                        Text("Value to convert")
                            .bold()
                        TextField("\(selectedCoinFrom)", text: $value)
                            .padding()
                            .background(.gray.opacity(0.1))
                            .clipShape(.rect(cornerRadius: 10))
                            .keyboardType(.numberPad)
                            .onChange(of: value) {
                                Task {
                                    convertedValue = await viewModel.calculateCoins(valueInfo: value, valueCoin: coins.first?.buyValue)
                                }
                                
                                viewModel.saveHistoryExchange(coin: coins.first!)
                            }
                    }
                    
                    HStack {
                        CoinPickerView(title: "From", coinTypes: coinTypes, coin: $selectedCoinFrom)
                            .onChange(of: selectedCoinFrom) {
                                value = ""
                                convertedValue = ""
                                
                                Task {
                                    await getCoins()
                                }
                            }
                        
                        Spacer()
                        
                        CoinPickerView(title: "To", coinTypes: coinTypes, coin: $selectedCoinTo)
                            .onChange(of: selectedCoinTo) {
                                value = ""
                                convertedValue = ""
                                
                                Task {
                                    await getCoins()
                                }
                            }
                        
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Converted Value")
                            .bold()
                        HStack {
                            Text("\(selectedCoinTo) \(convertedValue)")
                                .font(.largeTitle)
                                
                            Spacer()
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.accent.opacity(0.3))
                        .clipShape(.rect(cornerRadius: 15))
                    }
                    .padding()
                    .background(.regularMaterial)
                    .clipShape(.rect(cornerRadius: 20))
                }
                .navigationTitle("Coin Converter")
                .padding()
                .toolbar {
                    ToolbarItem {
                        NavigationLink {
                            HistoryExchangeView()
                        } label: {
                            Label("History", systemImage: "clock.arrow.circlepath")
                        }
                    }
                }
            }
            
            Spacer()
        }
        .onAppear {
            coinTypes = viewModel.getCoinsType()
            
            Task {
                await getCoins()
            }
        }
    }
}

#Preview {
    ContentView()
}
