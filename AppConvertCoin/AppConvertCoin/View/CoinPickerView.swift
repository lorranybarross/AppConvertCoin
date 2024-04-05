//
//  CoinPickerView.swift
//  AppConvertCoin
//
//  Created by Lorrany Barros on 04/04/24.
//

import SwiftUI

struct CoinPickerView: View {
    
    let title: String
    let coinTypes: [String]
    
    @Binding var coin: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .bold()
            Picker(title, selection: $coin) {
                ForEach(coinTypes, id: \.self) { coinType in
                    Text(coinType)
                }
            }
            .frame(maxWidth: .infinity)
            .background(.regularMaterial)
            .clipShape(.rect(cornerRadius: 20))
        }
    }
}

#Preview {
    CoinPickerView(title: "From", coinTypes: ["Coin 01", "Coin 02", "Coin 03"], coin: .constant(""))
}
