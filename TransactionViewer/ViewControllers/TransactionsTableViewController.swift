//
//  TransactionsTableViewController.swift
//  TransactionViewer
//
//  Created by vkrotin on 04.09.2018.
//  Copyright © 2018 vkrotin. All rights reserved.
//

import UIKit

class TransactionsTableViewController: UITableViewController {
    var transactions:[Transaction] = []
    
    @IBOutlet weak var totalLabel: UILabel!
    private let requestService = RequestService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let total = countTotal()
        totalLabel.text = "Total: " + String(format: "%.2f", total)  + " GBP"
        
        
        
    }
    
    // count Total
    
    func countTotal() -> Double {
        var total = 0.0
        for value in transactions{
            total = total + value.amountForGBP
        }
        return total
    }

    // MARK: - Table view data source
    
    
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        cell.textLabel?.text = "\(transactions[indexPath.row].amount)  \(transactions[indexPath.row].currency)"
        cell.detailTextLabel?.text = "\(transactions[indexPath.row].amountForGBP) GBP"
        
        return cell
    }
    
}
