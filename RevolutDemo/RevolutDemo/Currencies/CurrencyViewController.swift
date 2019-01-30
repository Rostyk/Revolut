//
//  ViewController.swift
//  RevolutDemo
//
//  Created by Apple on 1/29/19.
//  Copyright © 2019 Ross Stepaniak. All rights reserved.
//

import UIKit

let currencyCellID = "CurrencyTableViewCell"

class CurrencyViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var baseCurrencyLabel: UILabel!
    
    fileprivate lazy var controller: CurrencyController = {
        let controller = CurrencyController()
        controller.presentable = self
        return controller
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        controller.startCurrencyPoll()
    }
}

extension CurrencyViewController: CurrencyPresentable {
    internal func refreshCurrencies() {
        tableView.reloadData()
    }
}

extension CurrencyViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return controller.numerOfCurrencies()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: currencyCellID) as! CurrencyCell
        
        cell.delegate = self
        let currency = controller.getCurrency(indexPath.row)
        cell.flagLabel?.text = currency.code.emojiFlag()
        cell.currencyShortLabel?.text = currency.code
        cell.currencyFullLabel?.text = "Full currency name"
        cell.valueTextField?.text = String(format:"%.3f", currency.value)

        return cell
    }
}

extension CurrencyViewController: CurrencyCellDelegate {
    
    func didEndTyping(_ sender: CurrencyCell) {
        guard let indexPath = tableView.indexPath(for: sender)
            else { return }
        
        let currency = controller.getCurrency(indexPath.row)
        controller.baseCurrency = currency.code
        if let text = sender.valueTextField?.text {
            controller.baseAmount = (text as NSString).floatValue
        }
        baseCurrencyLabel.text = "Base currency: \(currency.code). Amount: \(controller.baseAmount)"
        
        controller.startCurrencyPoll()
    }
    
    func didBecameFirstResponder(_ sender: CurrencyCell) {
        controller.stopCurrencyPoll()
    }
}

