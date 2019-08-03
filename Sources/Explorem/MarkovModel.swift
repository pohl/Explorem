//
//  MarkovModel.swift
//  Explorem
//
//  Created by Pohl Longsine on 8/1/14.
//  Copyright (c) 2014 the screaming organization. All rights reserved.
//

import Foundation

public struct State: CustomStringConvertible, Equatable, Hashable {
    let penultimate: String?
    let ultimate: String?
    
    init(penultimate: String?, ultimate: String?) {
        self.penultimate = penultimate
        self.ultimate = ultimate
    }
    
    init() {
        self.penultimate = nil
        self.ultimate = nil
    }
    
    public var description: String {
        return "(\(penultimate ?? ""),\(ultimate ?? ""))"
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(penultimate)
        hasher.combine(ultimate)
    }    
}

public func == (lhs: State, rhs: State) -> Bool {
    return lhs.penultimate == rhs.penultimate && lhs.ultimate == rhs.ultimate
}

public class StateEdges {
    private var subsequentWords: Multiset<String> = Multiset()
    private var total: UInt32 = 0;
    
    init() {
    }
    
    func addWord(word: String) {
        subsequentWords.add(item: word);
        total = total + 1;
    }
    
    func nextState(current: State) -> State {
        let randomNumber = Int(arc4random_uniform(total))
        var n = 0;
        for (word, count) in subsequentWords {
            n = n + count;
            if (n > randomNumber) {
                return State(penultimate: current.ultimate, ultimate: word)
            }
        }
        return State()
    }
}
