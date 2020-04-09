//
//  TransactionUI.swift
//  TransactionViewer
//
//  Created by vkrotin on 09.04.2020.
//  Copyright © 2020 vkrotin. All rights reserved.
//

import Foundation


extension Array where Element:Transaction {
    
    func totalStringGBP() -> String {
      return "Total: " + String(format: "%.2f", map({$0.amountForGBP}).reduce(0, +)) + " GBP"
    }
    
    
    func amountCurrencyString(_ index : Int) -> String {
        return "\(self[index].amount)  \(self[index].currency)"
    }
    
    func amountStringGBP(_ index: Int) -> String {
        return  "\(self[index].amountForGBP.roundToDecimal(2)) GBP"
    }
}
