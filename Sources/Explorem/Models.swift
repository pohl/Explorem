//
//  Models.swift
//  SeinfeldChain
//
//  Created by pohl on 6/24/14.
//  Copyright (c) 2014 pohl. All rights reserved.
//

import Foundation


enum Token: Equatable, Hashable {
    case Word(String)
    case Punctuation(String)
    
    var description: String {
        switch self {
        case .Word(let w):
            return w
        case .Punctuation(let p):
            return p
        }
    }
    
    func hash(into hasher: inout Hasher) {
        switch self {
        case .Word(let w):
            hasher.combine(w.hashValue)
        case .Punctuation(let p):
            hasher.combine(p.hashValue)
        }
    }
    
    var isWord: Bool {
        switch self {
        case .Word(_):
            return true
        default:
            return false
        }
    }
    
}

func == (lhs: Token, rhs: Token) -> Bool {
    switch (lhs, rhs) {
    case (.Word(let w1), .Word(let w2)):
        return w1 == w2
    case (.Punctuation(let p1), .Punctuation(let p2)):
        return p1 == p2
    default:
        return false
    }
}

struct Sentence: CustomStringConvertible, Equatable, Hashable {
    var tokens:[Token]
    
    init(fromTokens t: [Token]) {
        tokens = t
    }
    
    var words: [String] {
    return tokens.filter {
        t in t.isWord
        }.map {
            $0.description
        }    
    }
    
    var description: String {
        return tokens.map { $0.description }.joined(separator: " | ")
        //return "sentence has \(phrases.count) phrases"
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(tokens)
    }
    
}

func == (lhs: Sentence, rhs: Sentence) -> Bool {
    return lhs.tokens == rhs.tokens
}

