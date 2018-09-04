//
//  RequestService.swift
//  TransactionViewer
//
//  Created by vkrotin on 04.09.2018.
//  Copyright © 2018 vkrotin. All rights reserved.
//

import Foundation


class RequestService {
    
    private var rates:[Rate] = []
    
    //MARK: -Main requests
    
    func getAllTransaction(completion: @escaping ([String: [Transaction]]) -> Swift.Void){
        DispatchQueue(label: "back1.queue").async {
            var products = [String: [Transaction]]()
            
            if let path = Bundle.main.path(forResource: "transactions", ofType: "plist"),
            let arrayPlist = NSArray(contentsOfFile: path) as? [[String: AnyObject]]{
                for object in arrayPlist{
                    guard let transaction = Transaction.init(dict: object),
                          let skuKey = object["sku"] as? String else{
                            continue
                    }
                    
                    if products.index(forKey:skuKey) == nil {
                        products[skuKey] = [Transaction]()
                    }
                    products[skuKey]?.append(transaction)
                }
            }
            
            self.getAllRates(completion: {[weak self] rates in
                self?.rates = rates
            })
            
            DispatchQueue.main.async {
                completion(products)
            }
        }
    }
    
    private func getAllRates(completion: @escaping ([Rate]) -> Swift.Void){
        var rates:[Rate] = []
        if let path = Bundle.main.path(forResource: "rates", ofType: "plist"),
            let arrayJson = NSArray(contentsOfFile: path){
            for object in arrayJson{
                
                guard let needObj = object as? [String : AnyObject] else{
                    continue
                }
                
                rates.append(Rate.init(dict: needObj)!)
            }
        }
        completion(rates)
    }
    
    //MARK: - counting Amount
    
    func containsAllAmount(for array:[Transaction], toCurrency:String, completion: @escaping ([Transaction]) -> Swift.Void){
        DispatchQueue(label: "back2.queue").async {
            for transaction in array{
                if transaction.currency == "GBP"{
                    transaction.amountForGBP = transaction.amount
                    continue
                }
                
                let rates = self.getRateFor(from: transaction.currency, rateValue: 1.0)
                transaction.amountForGBP = rates * transaction.amount
                
            }
            
            DispatchQueue.main.async {
                completion(array)
            }
        }
     
        
    }
    
    
   private func getRateFor(from:String, rateValue:Double) -> Double{
        let filteredArray = self.rates.filter( { (rate: Rate) -> Bool in
            return rate.from == from
        })

        guard let rate = filteredArray.first else{
            return 1.0
        }
        
        var totalRate = rateValue * rate.rate
        if rate.to != "GBP"{
            totalRate = self.getRateFor(from: rate.to, rateValue: totalRate)
        }
        return totalRate
    }

    
}
