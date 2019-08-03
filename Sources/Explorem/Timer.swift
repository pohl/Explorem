//
//  Timer.swift
//  Explorem
//
//  Created by Pohl Longsine on 7/28/14.
//  Copyright (c) 2014 the screaming organization. All rights reserved.
//

import Foundation

func stopwatch(block: () -> Void) -> Double {
    var start = NSDate()
    block()
    var end = NSDate()
    let timeTaken = end.timeIntervalSince(start as Date) * 1000
    return timeTaken
}
