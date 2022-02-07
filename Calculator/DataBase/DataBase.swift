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
    
    let realm = try! Realm()
    
    var calculations: Results<Calculations>!

}

class Calculations: Object{
    @objc dynamic var operation = ""
    @objc dynamic var result = ""
}
