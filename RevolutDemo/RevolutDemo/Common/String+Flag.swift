//
//  String+Flag.swift
//  RevolutDemo
//
//  Created by Apple on 1/29/19.
//  Copyright © 2019 Ross Stepaniak. All rights reserved.
//

import Foundation

extension String {
    public func emojiFlag() -> String {
        let base : UInt32 = 127397
        var s = ""
        for v in self.unicodeScalars {
            s.unicodeScalars.append(UnicodeScalar(base + v.value)!)
        }
        return String(s.prefix(s.count - 1))
    }
}
