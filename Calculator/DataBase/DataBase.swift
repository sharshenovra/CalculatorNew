//
//  DataBase.swift
//  Calculator
//
//  Created by Ruslan Sharshenov on 07.02.2022.
//

import Foundation
import RealmSwift

// Создаём нашу Базу Данных
class DataBase {
    
    public static let shared = DataBase() // Создаём переменную shared через которую мы сможем обращаться к переменным в нашей Базе данных из любой части кода
    
    private lazy var realm: Realm? = { // Создаём переменную которая будет давать нам доступ к библитеке Realm(База Данных)
        do {
            return try Realm() // Если библиотека есть - использовать библиотеку
        } catch {
            return nil // Если нет, то переменная будет равна nil
        }
    }()
    
    func saveHistory(model: HistoryModel) { // Создаём функцию которая будет сохранять нашу модель в Базе Данных
        do { // Если есть доступ к БазеДанных
            try realm?.write{ // Используем метод, который позволяет нам записывать(добавлять, удалять и т.д) данные в Базу Данных
                realm?.add(model) // Добавляем нашу модель в Базу Данных
            }
        } catch { // Если доступа нет
            print("DataBase not work saveHistory") // Выводим в консоль "DataBase not work saveHistory"
        }
    }
    
    func getHistory() -> Results<HistoryModel>? { // Создаём функцию которая будет при её использовании выдавать все данные добавленные по нашей модели из Базу Данных из класса HistoryModel
        return realm?.objects(HistoryModel.self) // Возвращаем массив из наших моделей полученных из Базы Данных
    }
    
    func deleteAllHistory() { // Создаём функцию которая удаляет всю нашу историю
        do { // Если есть доступ к Базе Данных
            try realm?.write{ // Используем метод, который позволяет нам записывать(добавлять, удалять и т.д) данные в Базу Данных
                realm?.deleteAll() // Удаляем все данные из нашей Базы Данных
            }
        } catch { // Если доступа к Базе Данных нет
            print("DataBase not work saveHistory") // Выводим в консоль "DataBase not work saveHistory"
        }
    }
}
