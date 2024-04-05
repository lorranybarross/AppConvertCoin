//
//  HomeViewModel.swift
//  AppConvertCoin
//
//  Created by Lorrany Barros on 05/04/24.
//

import Foundation

struct HomeViewModel {
    let service: WebService
    private var historyUserDefaults = HistoryUserDefaults.shared
    
    init(service: WebService) {
        self.service = service
    }
    
    func getCoins(endpoint: String) async throws -> [Coin]? {
        do {
            let result = try await service.getCoins(endpoint: endpoint)
            return result
        } catch {
            print("Error to get coins: \(error.localizedDescription)")
            return nil
        }
    }
    
    func calculateCoins(valueInfo: String, valueCoin: String?) async -> String {
        let value: Double? = Double(valueInfo)
        guard let valueCoin else { return "" }
        let coin: Double? = Double(valueCoin)
        
        guard let value, let coin else { return "" }
        
        let calculation = value * coin
        let calculationString = String(format: "%g", calculation)
        return calculationString
    }
    
    func getCoinsType() -> [String] {
        EnumCoins.allCases.map { $0.rawValue }
    }
    
    func saveHistoryExchange(coin: Coin) {
        var listCoin = self.getHistoryExchange()
        if listCoin.count > 0 {
            let listAux = listCoin.filter { $0.code == coin.code && $0.codein == coin.codein }
            if listAux.count > 0 {
                return
            }
        }
        
        listCoin.append(coin)
        self.historyUserDefaults.save(coinsList: listCoin)
        print(listCoin)
    }
    
    func getHistoryExchange() -> [Coin] {
        self.historyUserDefaults.getCoinsList()
    }
    
    func deleteHistoryExchange() {
        self.historyUserDefaults.deleteAll()
    }
}
