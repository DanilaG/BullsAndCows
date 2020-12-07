//
//  main.swift
//  BullsAndCows
//
//  Created by Danila on 05.12.2020.
//

import Foundation

typealias AttemptResult = (bulls: UInt, cows: UInt)

class Number {
    private var number = Array<Int>(repeating: 0, count: 10)
    let capacity: Int
    
    var value: Int {
        var answer: Int = 0
        for (numeral, position) in number.enumerated() where position > 0 {
            answer += numeral * Int(pow(10.0, Double(position - 1)))
        }
        return answer
    }
    
    init?(number: String) {
        capacity = number.count
        var counter = 0
        for i in number {
            if let numeral = i.wholeNumberValue, self.number[numeral] == 0 {
                self.number[numeral] = capacity - counter
                counter += 1
            } else {
                return nil
            }
        }
    }
    
    static func ==(lhs: Number, rhs: Number) -> AttemptResult? {
        if (lhs.capacity != rhs.capacity) {
            return nil
        }
        var answer = (bulls: UInt(0), cows: UInt(0))
        for i in lhs.number.indices {
            if (lhs.number[i] != 0 && rhs.number[i] != 0) {
                if (lhs.number[i] == rhs.number[i]) {
                    answer.bulls += 1
                } else {
                    answer.cows += 1
                }
            }
        }
        return answer
    }
}

class BullsAndCows {
    private let numberCapacity = 4
    private var hiddenNumber: Number!
    
    func start() {
        printWelcome()
        printRules(numberCapacity: numberCapacity)
        repeat {
            restart()
            if (!plaing()) {
                printLoserMessage(hiddenNumber: hiddenNumber, numberCapacity: numberCapacity)
                return
            }
            printWinnerMessage()
        } while (askNewParty())
    }
    
    private func plaing() -> Bool {
        var attemptResult: AttemptResult?
        repeat {
            if let readNumber = askGiveUpOrNumber(capacity: numberCapacity) {
                attemptResult = (readNumber == hiddenNumber)!
                printAttempt(result: attemptResult!)
            } else {
                return false
            }
        } while (attemptResult!.bulls != numberCapacity)
        return true
    }
    
    private func restart() {
        hiddenNumber = generateNumber()
    }
    
    private func generateNumber() -> Number {
        let numerals = 0...9
        let number = numerals.shuffled()[0..<numberCapacity].reduce(""){ $0 + String($1) }
        return Number(number: number)!
    }
}

BullsAndCows().start()
