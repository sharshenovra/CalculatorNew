//
//  HistoryViewModel.swift
//  Calculator
//
//  Created by Ruslan Sharshenov on 08.02.2022.
//

import Foundation
import RealmSwift

// Создаём протокол(обязательное условие при его использовании) который будет содержать в себе одну обязательную при использовании функцию
protocol HistoryDelegate: AnyObject {
    func showHistory(model: Results<HistoryModel>) // Указываем функцию которая будет показывать результаты из Базы Данных по нашей модели
}

// Создаём нашу HistoryViewModel которая будет отвечать за логику между контроллером и UI-элементаим
class HistoryViewModel {
    
    private weak var delegate: HistoryDelegate? = nil  // Создаём переменную weak(чтобы даже если что-то произойдёт эта переменная продолжала существовать) которая будет давать нам доступ к методам делегата с параметром private
    
    weak var historyDelegate: HistorySelectDelegate? = nil   // Создаём переменную weak(чтобы даже если что-то произойдёт эта переменная продолжала существовать) которая будет давать нам доступ к методам делегата
    
    init(delegate: HistoryDelegate) { // Создаём инициализатор который будет в себе принимать протокол
        self.delegate = delegate// Протокол созданный ранее будет равен указанному при использовании переменной

    }
    
    func selecthistory(model: HistoryModel) { // Создаём функцию которая будет в себе принимать нашу модель
        historyDelegate?.selectHistory(model: model) // Указываем что функция прописанная ранее будет принимать в себе модель указанную при использовании этой функции
    }
    
    func deleteAllHistory() { // Создаём функцию которая будет удалять всю историю
        DataBase.shared.deleteAllHistory() // Используем функцию deleteAllHistory для удаления которую мы создали в классе DataBase
        
        getHistory() // Используем функцию созданную ниже
    }
    
    func getHistory() { // Создаём функцию которая будет запрашивать данные из Базы Данных и обновлять данные в tableView
        if let history = DataBase.shared.getHistory() { // Указываем что если функция getHistory существует
            delegate?.showHistory(model: history) // Используя делегат показываем историю по модели 
        }
    }
}
