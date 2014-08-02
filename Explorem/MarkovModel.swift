//
//  MarkovModel.swift
//  Explorem
//
//  Created by Pohl Longsine on 8/1/14.
//  Copyright (c) 2014 the screaming organization. All rights reserved.
//

struct State: Printable, Equatable, Hashable {
    let penultimate: String?
    let ultimate: String?
    
    init(p: String, u: String) {
        penultimate = p
        ultimate = u
    }
    
    var description: String {
        return "(\(penultimate),\(ultimate))"
    }
    
    var hashValue: Int {
        var hashCode = 1
        if let p = penultimate {
            hashCode = 31 &* hashCode &+ p.hashValue
        }
        if let t = penultimate {
            hashCode = 31 &* hashCode &+ t.hashValue
        }
        return hashCode
    }
    
}

func == (lhs: State, rhs: State) -> Bool {
    return lhs.penultimate == rhs.penultimate && lhs.ultimate == rhs.ultimate
}
