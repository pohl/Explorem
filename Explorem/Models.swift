//
//  Models.swift
//  SeinfeldChain
//
//  Created by pohl on 6/24/14.
//  Copyright (c) 2014 pohl. All rights reserved.
//

import Foundation

class Word: Printable, Equatable, Hashable {
    var spelling:String
    var count = 1
    
    init(fromString string:String) {
        spelling = string.lowercaseString
    }
    
    var description: String {
        return spelling
    }
    
    var hashValue: Int {
        return spelling.hashValue
    }
    
}

func == (lhs: Word, rhs: Word) -> Bool {
    return lhs.spelling == rhs.spelling
}






class Phrase: Printable, Equatable, Hashable {
    var words:[Word]
    
    init(fromWords w: [Word]) {
        words = w
    }
    
    var description: String {
        return NSArray.componentsJoinedByString(words.map { $0.description })(",")
    }
    
    var hashValue: Int {
        var hashCode = 1
        for w in words {
            hashCode = 31 &* hashCode &+ w.hashValue
        }
        return hashCode
    }
    
}

func == (lhs: Phrase, rhs: Phrase) -> Bool {
    return lhs.words == rhs.words
}


class Sentence: Printable, Equatable, Hashable {
    var phrases:[Phrase]
    
    init(fromPhrases p: [Phrase]) {
        phrases = p
    }
    
    var description: String {
        return NSArray.componentsJoinedByString(phrases.map { $0.description })(" | ")
        //return "sentence has \(phrases.count) phrases"
    }
    
    var hashValue: Int {
        var hashCode = 1
            for p in phrases {
                hashCode = 31 &* hashCode &+ p.hashValue
            }
        return hashCode
    }
    
}

func == (lhs: Sentence, rhs: Sentence) -> Bool {
    return lhs.phrases == rhs.phrases
}

