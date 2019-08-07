//
//  Timer.swift
//  Explorem
//
//  Created by Pohl Longsine on 7/28/14.
//  Copyright (c) 2014 the screaming organization. All rights reserved.
//

import Foundation

func stopwatch(block: () -> Void) -> Double {
    let start = Date()
    block()
    let end = Date()
    let timeTaken = end.timeIntervalSince(start) * 1000
    return timeTaken
}
