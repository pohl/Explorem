//
//  main.swift
//  Explorem
//
//  Created by Pohl Longsine on 7/27/14.
//  Copyright (c) 2014 the screaming organization. All rights reserved.
//

import Foundation

extension Int {
    func percent(of total: Int) -> Int {
        return (self * 200 + total)/(2 * total)
    }
}

private func displaySentences(_ sentenceCounts: Multiset<Sentence>) {
    let sortedSentences = sentenceCounts
        .dictionary
        .sorted(by: { $0.0.tokens.count < $1.0.tokens.count })
    for (key, value) in sortedSentences {
        print("\(value): \(key)")
    }
}

private func displayLengths<T>(_ counts: Multiset<T>) where T: HasWords {
    var lengths = Multiset<Int>()
    var total = 0
    for (key, value) in counts {
        lengths.add(item: key.words.count)
        total += value
    }
    let sortedLengths = lengths.dictionary.sorted(by: { $0.0 < $1.0 })
    for (key, value) in sortedLengths {
        print("\(key): \(value.percent(of: total))")
    }
}

private func displayWords(_ wordCounts: Multiset<String>) {
    let sortedWords = wordCounts.dictionary.sorted(by: { $0.1 < $1.1 })
    for (key, value) in sortedWords {
        print("\(value): \(key)")
    }
    print("\(wordCounts.dictionary.count) unique words in sample")
}

private func displayPhrases(_ phraseCounts: Multiset<Phrase>) {
    let sortedPhrases = phraseCounts
        .dictionary
        .sorted(by: { $0.0.tokens.count < $1.0.tokens.count })
        .sorted(by: { $0.1 < $1.1 })
    for (key, value) in sortedPhrases {
        print("\(value): \(key)")
    }
    print("\(phraseCounts.dictionary.count) unique phrases in sample")
}

private func displayRepeats<T>(_ counts: Multiset<T>) where T: HasWords {
    var repeats = Multiset<String>()
    for (key, _) in counts {
        repeats.add(items: key.findRepeatedWords())
    }
    let sortedRepeats = repeats
        .dictionary
        .sorted(by: { $0.1 < $1.1 })
    for (key, value) in sortedRepeats {
        print("\(value): \(key)")
    }
}

@available(OSX 10.12, *)
func run() -> () {
    let parser = LoremParser()
    let sentences: [Sentence] = parser
        .readAllSentences()
        .filter( {!cannedSentences.contains($0) })

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
        //displaySentences(sentenceCounts)
        //displayLengths(sentenceCounts)
        //displayRepeats(sentenceCounts)
        //displayWords(wordCounts)
        //displayPhrases(phraseCounts)
        //displayLengths(phraseCounts)
        displayRepeats(sentenceCounts)

    }
    print("elapsed == \(elapsed)")
}

if #available(OSX 10.12, *) {
    run()
} else {
    // Fallback on earlier versions
}



