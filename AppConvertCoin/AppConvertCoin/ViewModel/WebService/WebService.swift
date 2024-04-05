//
//  WebService.swift
//  AppConvertCoin
//
//  Created by Lorrany Barros on 04/04/24.
//

import Foundation

struct WebService {
    private let baseURL: String = "https://economia.awesomeapi.com.br/json/last/"
    
    func getCoins(endpoint: String) async throws -> [Coin]? {
        let urlWithEndpoint = baseURL + endpoint
        guard let url = URL(string: urlWithEndpoint) else {
            print("Invalid URL")
            return nil
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let coins = try JSONDecoder().decode([String: Coin].self, from: data)
        let coinsList = Array(coins.values)
        
        return coinsList
    }
}
