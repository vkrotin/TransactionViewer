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
    
}

 // MARK: - Table view data source

extension TransactionsTableViewController {
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return transactions.totalStringGBP()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        cell.textLabel?.text = transactions.amountCurrencyString(indexPath.row)
        cell.detailTextLabel?.text = transactions.amountStringGBP(indexPath.row)
        
        return cell
    }
    
}
