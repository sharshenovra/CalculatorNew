//
//  HistoryModel.swift
//  Calculator
//
//  Created by Ruslan Sharshenov on 08.02.2022.
//

import Foundation
import RealmSwift

// Создаём нашу модель в БазеДанных
class HistoryModel: Object {
    @objc dynamic var math = "" // Указываем что наша переменная math, в будущем хранящая в себе математическое выражение будет изначально пустой ("")
    @objc dynamic var result = "" // Указываем что наша переменная result, в будущем хранящая в себе результат математического выражения будет изначально пустой ("")

    static func createHistory(math: String, result: String) -> HistoryModel { // Создаём функцию которая будет создавать модель
        let model = HistoryModel() // Указываем что модель будет создана как HistoryModel()
        model.math = math // Указываем что переменная math в нашей модели будет равна math, указанному при использовании функции
        model.result = result // Указываем что переменная result в нашей модели будет равна result, указанному при использовании функции
        return model // Возвращаем нашу модель
    }
}

