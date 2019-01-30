//
//  KeyboardAdjustableTableView.swift
//  RevolutDemo
//
//  Created by Apple on 1/30/19.
//  Copyright © 2019 Ross Stepaniak. All rights reserved.
//

import UIKit

class KeyboardAdjustableTableView: UITableView {
    let insetViewHeight: CGFloat = 40.0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.tableFooterView = UIView(frame: CGRect.zero)
        setupNonFloatingHeader()
        addKeyboardObservers()
    }
    
    private func addKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: .UIKeyboardWillHide, object: nil)
    }
    
    private func removeObservers() {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func setupNonFloatingHeader() {
        self.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: insetViewHeight))
        self.contentInset = UIEdgeInsets(top: -insetViewHeight, left: 0, bottom: 0, right: 0)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let keyboardHeight = (userInfo[UIKeyboardFrameEndUserInfoKey] as AnyObject).cgRectValue.size.height
            self.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: insetViewHeight))
            self.contentInset = UIEdgeInsets(top: -insetViewHeight, left: 0, bottom: keyboardHeight, right: 0)
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        UIView.animate(withDuration: 0.25) {
            self.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.insetViewHeight))
            self.contentInset = UIEdgeInsets(top: -self.insetViewHeight, left: 0, bottom: 0, right: 0)
        }
    }
    
    deinit {
        removeObservers()
    }
}
