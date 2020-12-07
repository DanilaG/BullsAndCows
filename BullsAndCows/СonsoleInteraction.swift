//
//  ConsoleInteraction.swift
//  BullsAndCows
//
//  Created by Danila on 06.12.2020.
//

import Foundation

fileprivate enum TextConst: String {
    case confirm = "д"
    case refuse = "н"
    case exit = "в"
}

func printWelcome() {
    print("""
          Добро пожаловать в долгожданную игру Быки И Коровы!
          Перед началом игры рекомендуем ознакомиться с правилами.
          """)
}

func printRules(numberCapacity: Int) {
    print("""
          Правила игры:
          Компьютер загадываете число из \(numberCapacity) неповторяющихся цифр.
          Ваша задача - отгадать его.
          Если в предложенном Вами числе n цифр находятся на тех же местах что и в загаданном,
          Вы получите n быков.
          Если же в ведённом Вами варианте m цифр содержится в загадочном, но их разряды не совпадают,
          Вы получите m коров.
          """)
}

func printLoserMessage(hiddenNumber: Number, numberCapacity: Int) {
    print("""
          Вы проиграли!
          Загаданное число: \(hiddenNumber.value).
          Как Вы вообще сумели дожить до своих лет, если не можете отгодать число из \(numberCapacity) символов?!
          """)
}

func printWinnerMessage() {
    print("Поздравляем! Вы отгадали загаданное число. 🏆")
}

func printAttempt(result: AttemptResult) {
    print("Быков: \(result.bulls); Коров: \(result.cows).")
}

func askNewParty() -> Bool {
    print("Хотите сиграть новую партию? (\(TextConst.confirm.rawValue) / \(TextConst.refuse.rawValue))")
    if let answer = readLine() {
        switch answer.lowercased() {
        case TextConst.confirm.rawValue:
            return true
        case TextConst.refuse.rawValue:
            return false
        default:
            print("В случае есле вы хотите продолжить игру введите \"\(TextConst.confirm.rawValue)\", иначе \"\(TextConst.refuse.rawValue)\".")
            return askNewParty()
        }
    }
    return askNewParty()
}

func askGiveUpOrNumber(capacity: Int) -> Number? {
    print("Введите число: ", terminator: "")
    if let read = readLine() {
        if read.lowercased() == TextConst.exit.rawValue {
            return nil
        }
        if let number = Number(number: read), number.capacity == capacity {
            return number
        }
    }
    print("Число должно быть целым из \(capacity) не повторяющихся цифр!")
    print("Если же вы решили сдаться напечатайте \(TextConst.exit.rawValue).")
    return askGiveUpOrNumber(capacity: capacity)
}
