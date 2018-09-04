//
//  ProductsTableViewController.swift
//  TransactionViewer
//
//  Created by vkrotin on 04.09.2018.
//  Copyright © 2018 vkrotin. All rights reserved.
//

import UIKit

class ProductsTableViewController: UITableViewController {
    
    private let requestService = RequestService()
    var productDict:NSDictionary = NSDictionary()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestService.getAllTransaction(completion: {[weak self] transactions in
            self?.productDict = transactions as NSDictionary
            self?.tableView.reloadData()
        })
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productDict.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        guard let key = productDict.allKeys[indexPath.row] as? String,
              let array = productDict.object(forKey: key) as? [Transaction] else{
            return cell
        }
        
        cell.textLabel?.text = key
        cell.detailTextLabel?.text = "\(array.count) transactions"

        return cell
    }


    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let key = productDict.allKeys[indexPath.row] as? String,
            let array = productDict.object(forKey: key) as? [Transaction] else{
                return
        }
        requestService.containsAllAmount(for: array, toCurrency: "GBP",  completion: {[weak self] totalArray in
            self?.performSegue(withIdentifier: "toDetail", sender: [key : totalArray])
        })
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toDetail"{
            guard let transactionTableView = segue.destination as? TransactionsTableViewController,
            let object = sender as? [String: [Transaction] ],
            let key = object.keys.first,
                let array = object.values.first else{
                return
            }
            transactionTableView.title = "Transaction for " + key
            transactionTableView.transactions = array
            
        
        }
        
    }
  

}
