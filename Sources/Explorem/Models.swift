//
//  Models.swift
//  SeinfeldChain
//
//  Created by pohl on 6/24/14.
//  Copyright (c) 2014 pohl. All rights reserved.
//

import Foundation


protocol HasWords: Hashable {
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
    
    var isSentenceTerminator: Bool {
        switch self {
        case .Word:
            return false
        case .Punctuation(let p):
            return p != ","
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
    
    var isSentenceTerminator: Bool {
        return tokens
            .filter { $0.isSentenceTerminator }
            .count != 0
    }
}

struct Sentence: CustomStringConvertible, HasWords {
    var phrases:[Phrase]
    
    init(fromPhrases p: [Phrase]) {
        phrases = p
    }
    
    var tokens: [Token] {
        return phrases
            .map { $0.tokens }
            .flatMap { $0 }
    }
    
    var words: [String] {
        return phrases
            .map { $0.words }
            .flatMap { $0 }
    }
    
    var description: String {
        return tokens.map { $0.description }.joined(separator: " ")
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(phrases)
    }    
}

struct Paragraph: CustomStringConvertible, HasWords {
    var sentences:[Sentence]
    
    init(fromSentences p: [Sentence]) {
        sentences = p
    }
    
    var tokens: [Token] {
        return sentences
            .map { $0.tokens }
            .flatMap { $0 }
    }
    
    var words: [String] {
        return sentences
            .map { $0.words }
            .flatMap { $0 }
    }
    
    var description: String {
        return tokens.map { $0.description }.joined(separator: " ")
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(sentences)
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


