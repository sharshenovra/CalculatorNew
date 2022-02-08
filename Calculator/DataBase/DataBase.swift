//
//  DataBase.swift
//  Calculator
//
//  Created by Ruslan Sharshenov on 07.02.2022.
//

import Foundation
import RealmSwift

class DataBase {
    
    public static let shared = DataBase()
    
    private lazy var realm: Realm? = {
        do {
            return try Realm()
        } catch {
            return nil
        }
    }()
    
    func saveHistory(model: HistoryModel) {
        do {
            try realm?.write{
                realm?.add(model)
            }
        } catch {
            print("DataBase not work saveHistory")
        }
    }
    
    func getHistory() -> Results<HistoryModel>? {
        return realm?.objects(HistoryModel.self)
    }
    
    func deleteAllHistory() {
        do {
            try realm?.write{
                realm?.deleteAll()
            }
        } catch {
            print("DataBase not work saveHistory")
        }
    }
}
