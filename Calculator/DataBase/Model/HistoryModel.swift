//
//  HistoryModel.swift
//  Calculator
//
//  Created by Ruslan Sharshenov on 08.02.2022.
//

import Foundation
import RealmSwift

class HistoryModel: Object {
    @objc dynamic var math = ""
    @objc dynamic var result = ""

    static func createHistory(math: String, result: String) -> HistoryModel {
        let model = HistoryModel()
        model.math = math
        model.result = result
        return model
    }
}

