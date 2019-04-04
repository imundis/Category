//
//  GCDTimerManager+Times.swift
//  Category
//
//  Created by 郭帅 on 2018/12/12.
//  Copyright © 2018 Category. All rights reserved.
//

import Foundation

private var timesKey: Void?

extension GCDTimerManager {
    var times: Int? {
        get {
            return objc_getAssociatedObject(self, &timesKey) as? Int
        }
        set {
            objc_setAssociatedObject(self, &timesKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

