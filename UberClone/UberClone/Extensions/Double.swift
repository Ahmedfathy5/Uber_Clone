//
//  Double.swift
//  UberClone
//
//  Created by Ahmed Fathi on 31/01/2024.
//

import Foundation


extension Double {
    
    private var currencyFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        return formatter
    }
    
    func toCurrency() -> String {
        return currencyFormatter.string(from: self as NSNumber) ?? " "
                 }
    
}
