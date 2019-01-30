//
//  CurrencyCellTableViewCell.swift
//  RevolutDemo
//
//  Created by Apple on 1/29/19.
//  Copyright © 2019 Ross Stepaniak. All rights reserved.
//

import UIKit

protocol CurrencyCellDelegate : NSObjectProtocol {
    func didBecameFirstResponder(_ sender: CurrencyCell)
    func didEndTyping(_ sender: CurrencyCell)
}

class CurrencyCell: UITableViewCell {
    @IBOutlet weak var flagLabel: UILabel?
    @IBOutlet weak var currencyShortLabel: UILabel?
    @IBOutlet weak var currencyFullLabel: UILabel?
    @IBOutlet weak var valueTextField: UITextField?
    
    weak var delegate: CurrencyCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        addDoneButtonOnKeyboard()
    }
    
    func addDoneButtonOnKeyboard()
    {
        
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
        doneToolbar.barStyle = UIBarStyle.default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(CurrencyCell.doneButtonAction))
        
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.valueTextField?.inputAccessoryView = doneToolbar
    }
    
    
   @objc func doneButtonAction(){
        self.valueTextField?.resignFirstResponder()
    }
}

extension CurrencyCell: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.didEndTyping(self)
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        delegate?.didBecameFirstResponder(self)
        return true;
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }

}
