//
//  main.swift
//  Explorem
//
//  Created by Pohl Longsine on 7/27/14.
//  Copyright (c) 2014 the screaming organization. All rights reserved.
//

import Foundation

@available(OSX 10.12, *)
func run() -> () {
    let parser = LoremParser()
    let sentences: [Sentence] = parser.readAllSentences()

    let elapsed = stopwatch {
        var sentenceCounts = Multiset<Sentence>()
        var phraseCounts = Multiset<Phrase>()
        var wordCounts = Multiset<String>()
        for sentence in sentences {
            sentenceCounts.add(item: sentence)
            for phrase in sentence.phrases {
                phraseCounts.add(item: phrase)
            }
            for word in sentence.words {
                wordCounts.add(item: word)
            }
        }
        let sortedSentences = sentenceCounts
            .dictionary
            .sorted(by: { $0.0.tokens.count < $1.0.tokens.count })
            .sorted(by: { $0.1 < $1.1 })
//        for (key, value) in sortedSentences {
//            print("\(value): \(key)")
//        }
//        let sortedWords = wordCounts.dictionary.sorted(by: { $0.1 < $1.1 })
//        for (key, value) in sortedWords {
//            print("\(value): \(key)")
//        }
//        print("\(wordCounts.dictionary.count) unique words in sample");
        let sortedPhrases = phraseCounts
            .dictionary
            .sorted(by: { $0.0.tokens.count < $1.0.tokens.count })
            .sorted(by: { $0.1 < $1.1 })
        for (key, value) in sortedPhrases {
            print("\(value): \(key)")
        }
        print("\(phraseCounts.dictionary.count) unique phrases in sample");
    }
    print("elapsed == \(elapsed)")
}

if #available(OSX 10.12, *) {
    run()
} else {
    // Fallback on earlier versions
}



