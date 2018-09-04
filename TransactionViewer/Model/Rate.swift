//
//  Rate.swift
//  TransactionViewer
//
//  Created by vkrotin on 04.09.2018.
//  Copyright © 2018 vkrotin. All rights reserved.
//

import Foundation

class Rate {
    let from: String
    let to: String
    let rate : Double

    init(_ from: String, _ to: String, _ rate: String) {
        self.from = from
        self.to = to
        self.rate = Double(rate)!
    }
    
    init?(dict:[String: AnyObject]) {
        guard
            let _from = dict["from"] as? String,
            let _to = dict["to"] as? String,
            let _rate = dict["rate"] as? String else { return nil }
        
        self.from = _from
        self.to = _to
        self.rate = Double(_rate)!
    }

}
