//
//  HistoryUserDefaults.swift
//  AppConvertCoin
//
//  Created by Lorrany Barros on 05/04/24.
//

import Foundation

class HistoryUserDefaults {
    static let shared = HistoryUserDefaults()
    private let historyKey = "kHistory"
    
    func save(coinsList: [Coin]) {
        do {
            let list = try JSONEncoder().encode(coinsList)
            UserDefaults.standard.set(list, forKey: historyKey)
        } catch {
            print(error)
        }
    }
    
    func getCoinsList() -> [Coin] {
        do {
            if let list = UserDefaults.standard.object(forKey: historyKey) as? Data {
                let listAux = try JSONDecoder().decode([Coin].self, from: list)
                return listAux
            }
        } catch {
            print(error)
        }
        
        return []
    }
    
    func deleteAll() {
        UserDefaults.standard.removeObject(forKey: historyKey)
    }
}
