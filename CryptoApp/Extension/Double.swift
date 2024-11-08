//
//  Double.swift
//  CryptoApp
//
//  Created by Subash Sethuraman A on 01/11/24.
//

import Foundation

extension Double {
    ///Convert double into currency format
    ///```
    ///Convert 123.3434 to $12.45
    ///```
    private var currencyFormatter6 : NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 6
        return formatter
    }
    
    func asCurrencyWithDecimals() -> String {
        let number = NSNumber(value: self)
        return currencyFormatter6.string(from: number) ?? "$0.0"
    }
    
    func asNumberString() -> String{
        return String(format: "%0.2f", self)
    }
    
    
    func numberAddPercentage() -> String {
      return  asNumberString() + "%"
    }
}
