//
//  Transaction.swift
//  TransactionViewer
//
//  Created by vkrotin on 04.09.2018.
//  Copyright © 2018 vkrotin. All rights reserved.
//

import Foundation

class Transaction {
    let amount: Double
    let currency: String
    let sku : String
    
    var amountForGBP:Double = 0
    
    
    
    init(_ currency: String, _ sku: String, _ amount: Double) {
        self.currency = currency
        self.sku = sku
        self.amount = amount
    }
    
    init?(dict:[String: AnyObject]) {
        guard
            let _currency = dict["currency"] as? String,
            let _sku = dict["sku"] as? String,
            let _amount = dict["amount"] as? String else { return nil }
        
        self.currency = _currency
        self.sku = _sku
        self.amount = Double(_amount)!
    }
    
}
