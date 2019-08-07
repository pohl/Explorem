//
//  Timer.swift
//  Explorem
//
//  Created by Pohl Longsine on 7/28/14.
//  Copyright (c) 2014 the screaming organization. All rights reserved.
//

import Foundation

func printMeasurement(title:String, operation:()->()) {
    let measurement = measure(operation: operation)
    let timeElapsed = Double(round(100*measurement)/100)
    print("Time elapsed for \(title): \(timeElapsed)s")
}

func measure (operation: ()->()) -> Double {
    let startTime = CFAbsoluteTimeGetCurrent()
    operation()
    let timeElapsed = CFAbsoluteTimeGetCurrent() - startTime
    return Double(timeElapsed)
}
