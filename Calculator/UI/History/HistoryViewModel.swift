//
//  HistoryViewModel.swift
//  Calculator
//
//  Created by Ruslan Sharshenov on 08.02.2022.
//

import Foundation
import RealmSwift

protocol HistoryDelegate: AnyObject {
    func showHistory(model: Results<HistoryModel>)
}

class HistoryViewModel {
    
    private weak var delegate: HistoryDelegate? = nil
    
    weak var historyDelegate: HistorySelectDelegate? = nil
    
    init(delegate: HistoryDelegate) {
        self.delegate = delegate
    }
    
    func selecthistory(model: HistoryModel) {
        historyDelegate?.selectHistory(model: model)
    }
    
    func deleteAllHistory() {
        DataBase.shared.deleteAllHistory()
        
        getHistory()
    }
    
    func getHistory() {
        if let history = DataBase.shared.getHistory() {
            delegate?.showHistory(model: history)
        }
    }
}
