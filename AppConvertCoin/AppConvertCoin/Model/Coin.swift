//
//  Coin.swift
//  AppConvertCoin
//
//  Created by Lorrany Barros on 04/04/24.
//

import Foundation

class Coin: Codable {
    let code: String?
    let codein: String?
    let name: String?
    let maxValue: String
    let minValue: String
    let percentageChange: String
    let buyValue: String
    let sellValue: String
    let variationBuyValue: String
    
    enum CodingKeys: String, CodingKey {
        case code, codein, name
        case maxValue = "high"
        case minValue = "low"
        case percentageChange = "pctChange"
        case buyValue = "bid"
        case sellValue = "ask"
        case variationBuyValue = "varBid"
    }
    
    init(code: String? = nil, codein: String? = nil, name: String? = nil, maxValue: String, minValue: String, percentageChange: String, buyValue: String, sellValue: String, variationBuyValue: String) {
        self.code = code
        self.codein = codein
        self.name = name
        self.maxValue = maxValue
        self.minValue = minValue
        self.percentageChange = percentageChange
        self.buyValue = buyValue
        self.sellValue = sellValue
        self.variationBuyValue = variationBuyValue
    }
    
    // It only converts the value if it exists
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.code = try values.decodeIfPresent(String.self, forKey: .code)
        self.codein = try values.decodeIfPresent(String.self, forKey: .codein)
        self.name = try values.decodeIfPresent(String.self, forKey: .name)
        self.maxValue = try values.decode(String.self, forKey: .maxValue)
        self.minValue = try values.decode(String.self, forKey: .minValue)
        self.variationBuyValue = try values.decode(String.self, forKey: .variationBuyValue)
        self.percentageChange = try values.decode(String.self, forKey: .percentageChange)
        self.buyValue = try values.decode(String.self, forKey: .buyValue)
        self.sellValue = try values.decode(String.self, forKey: .sellValue)
    }
}

extension Coin {
    static var coinMock: Coin {
        Coin(code: "USD", codein: "BRL", name: "Dólar Americano/Real Brasileiro", maxValue: "5.734", minValue: "5.7279", percentageChange: "-0.09", buyValue: "5.7276", sellValue: "5.7282", variationBuyValue: "-0.0054")
    }
}
