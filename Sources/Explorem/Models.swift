//
//  Models.swift
//  SeinfeldChain
//
//  Created by pohl on 6/24/14.
//  Copyright (c) 2014 pohl. All rights reserved.
//

import Foundation


protocol HasWords: Equatable, Hashable {
    var words: [String] { get }    
}

enum Token: Hashable {
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

struct Sentence: CustomStringConvertible, HasWords {
    var tokens:[Token]
    
    init(fromTokens t: [Token]) {
        tokens = t
    }
    
    var words: [String] {
        return tokens
            .filter { $0.isWord }
            .map { $0.description }
    }
    
    var phrases: [Phrase] {
        var phrases:[Phrase] = []
        var buffer:[Token] = []
        for token in tokens {
            buffer.append(token)
            if !token.isWord {
                let phrase = Phrase(fromTokens: buffer)
                phrases.append(phrase)
                buffer = []
            }
        }
        return phrases
    }
    
    var description: String {
        return tokens.map { $0.description }.joined(separator: " ")
    }
    
    var asSourceArray: String {
        var buffer = "let sentence:[Token] = [\n"
        for token in tokens {
            switch token {
            case .Word(let w):
                buffer.append(".Word(\"\(w)\"),\n")
            case .Punctuation(let p):
                buffer.append(".Punctuation(\"\(p)\"),\n")
            }
        }
        buffer.append("]\n")
        return buffer
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(tokens)
    }
    
}

struct Phrase: CustomStringConvertible, HasWords {
    var tokens:[Token]
    
    init(fromTokens t: [Token]) {
        tokens = t
    }
    
    var words: [String] {
        return tokens
            .filter { $0.isWord }
            .map { $0.description }
    }
    
    var description: String {
        return tokens.map { $0.description }.joined(separator: " ")
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(tokens)
    }
}

extension HasWords {
    func findRepeatedWords() -> Set<String> {
        let words = self.words
        var wordsUsed: Set<String> = Set()
        var repeatedWords: Set<String> = Set()
        for word in words {
            if wordsUsed.contains(word) {
                repeatedWords.insert(word)
            }
            wordsUsed.insert(word)
        }
        return repeatedWords
    }
    
    func hasRepatedWords() -> Bool {
        return findRepeatedWords().count != 0
    }
}


