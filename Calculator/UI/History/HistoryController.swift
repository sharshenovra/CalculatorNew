//
//  HistoryViewController.swift
//  Calculator
//
//  Created by Ruslan Sharshenov on 07.02.2022.
//

import Foundation
import UIKit
import SnapKit
import RealmSwift

// Создаём протокол(обязательное условие при его использовании) который будет содержать в себе одну обязательную при использовании функцию
protocol HistorySelectDelegate: AnyObject {
    func selectHistory(model: HistoryModel) // Указываем функцию которая будет выполнять действие при выборе элемента в истории
}

// Создаём наш HistoryController для истории
class HistoryController: UIViewController{
    
    private lazy var historyTableView = HistoryTableView() // Создаём historyTableView из ранее созданной HistoryTableView
    
    private lazy var clearButton = CustomButton(title: "Clear all")  // Создаём clearButton(кнопку) из ранее созданной CustomButton с title "Clear all"
    private lazy var backButton = CustomButton(title: "Back")  // Создаём backButton(кнопку) из ранее созданной CustomButton с title "Back"
    
    private lazy var viewModel: HistoryViewModel = {  // Создаём переменную которая будет содержать в себе нашу модель для истории
        return HistoryViewModel(delegate: self)  // Возвращаем нашу модель с использованием её делегата 
    }()
    
    public static func newInstanse(delegate: HistorySelectDelegate) -> HistoryController { // Создаём функцию которая принимаем в себе делегат и возвращает HistoryController
        let controller = HistoryController() // Создаём переменную со значением нашего контроллера
        controller.viewModel.historyDelegate = delegate // Указываем что в нашем контроллере делегат будет равен делегату который мы укажем при использовании функции
        return controller // Возвращаем контроллер
    }
    
    override func viewDidLoad() { // Метод который используется при создании экрана
        super.viewDidLoad() // Используем метод Swift
        
        setupConstraints() // Осуществляем реализацию функции описанной ниже
        setupMainWindow() // Осуществляем реализацию функции описанной ниже
        setupViews() // Осуществляем реализацию функции описанной ниже
        
        viewModel.getHistory() // Осуществляем реализацию функции описанной ниже
    }
    
    private func setupMainWindow() { // Создаём функцию которая будет менять фон
        view.backgroundColor = .black // Указываем что фон будет черный(.black)
    }
    
    func setupViews(){ // Создаём функцию которая будет отвечать за параметры наших элементов
        historyTableView.delegate = self // Указываем что наш tableView будет использовать собственный делегат
        
        backButton.setOnClickListener { view in  // Создаём действие для нашей кнопки backButton используя метод setOnClickListener прописанный в CustomButton
            self.navigationController?.popToRootViewController(animated: true) // Указываем что будет совершен переход на исходный(Main) контроллер с анимацией
        }
        
        clearButton.setOnClickListener { view in  // Создаём действие для нашей кнопки clearButton используя метод setOnClickListener прописанный в CustomButton
            self.viewModel.deleteAllHistory() // Указываем что при нажатии будет выполнена функция удаления всей истории ранее созданная в нашей HistoryModel
        }
    }
    
    func setupConstraints(){ // Создаём функцию которая будет отвечать за разметку наших элементов
        view.addSubview(clearButton) // Добавляем clearButton в наш контроллер
        clearButton.snp.makeConstraints { make in // Задаем констрейнты
            make.top.equalTo(view.safeArea.top).offset(8) // Указываем что верх нашей кнопки будет в безопасном месте сверху с отступом в 8 пикселей
            make.right.equalToSuperview().offset(-8) // Указываем что справа она будет привязана к родителю с отступом в -8 пикселей
        }
        
        view.addSubview(backButton) // Добавляем clearButton в наш контроллер
        backButton.snp.makeConstraints { make in // Задаем констрейнты
            make.top.equalTo(view.safeArea.top).offset(8) // Указываем что верх нашей кнопки будет в безопасном месте сверху с отступом в 8 пикселей
            make.left.equalToSuperview().offset(8) // Указываем что слева она будет привязана к родителю с отступом в 8 пикселей
        }
        
        view.addSubview(historyTableView) // Добавляем historyTableView в наш контроллер
        historyTableView.snp.makeConstraints { make in // Задаем констрейнты
            make.width.equalToSuperview() // Указываем что ширина нашего historyTableView будет равна родителю
            make.top.equalTo(clearButton.snp.bottom) // Указываем что верх нашего historyTableView будет привязан к низу clearButton
            make.bottom.equalToSuperview() // Указываем что снизу наш historyTableView будет равен родителю
        }
    }
    
}

extension HistoryController: HistoryCellDelegate { // Используем расширение для использования делегата HistoryCellDelegate
    func onClick(model: HistoryModel) {  // Используем функцию которая будет срабатывать при нажатии на ячейку
        viewModel.selecthistory(model: model) // Указываем что выбранная клетка будет соответствовать нашей модели указанной при использовании функции
        
        self.navigationController?.popViewController(animated: true) // Указываем что будет совершен переход на исходный(Main) контроллер с анимацией
    }
}

extension HistoryController: HistoryDelegate { // Используем расширение для использования делегата HistoryDelegate
    func showHistory(model: Results<HistoryModel>) { // Используем функцию которая будет принимать в себе результаты из Базы Данных по нашей модели
        historyTableView.fill(models: model) // Указываем что наш tableView будет заполнен по модели указанной при использовании функции
    }
}
