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
        var wordCounts = Multiset<String>()
        for sentence in sentences {
            sentenceCounts.add(item: sentence)
            for word in sentence.words {
                wordCounts.add(item: word)
            }
        }
        for (key, value) in sentenceCounts {
            if value != 1 {
                print("\(value) occurrences of sentence \(key)")
            }
        }
        //            for (key, value) in phraseCounts {
        //                if value != 1 {
        //                    println("\(value) occurrences of phrase: \(key)")
        //                }
        //            }
        
        for (key, value) in wordCounts {
            if value != 0 {
                print("\(value) occurrences of word: \(key)")
            }
        }
        print("\(wordCounts.dictionary.count) unique words in sample");
    }
    print("elapsed == \(elapsed)")
}

if #available(OSX 10.12, *) {
    run()
} else {
    // Fallback on earlier versions
}



