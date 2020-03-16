//
//  Double+help.swift
//  TransactionViewer
//
//  Created by vkrotin on 16.03.2020.
//  Copyright © 2020 vkrotin. All rights reserved.
//

import Foundation

extension Double {
    
    func roundToDecimal(_ fractionDigits: Int) -> Double {
        let multiplier = pow(10, Double(fractionDigits))
        return Darwin.round(self * multiplier) / multiplier
    }
    
}
