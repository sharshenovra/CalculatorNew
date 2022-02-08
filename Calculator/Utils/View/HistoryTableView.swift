//
//  HistoryTableView.swift
//  Calculator
//
//  Created by Ruslan Sharshenov on 07.02.2022.
//

import Foundation
import UIKit
import SnapKit
import RealmSwift
import SwiftUI

// Создаём протокол(обязательное условие при его использовании)
protocol HistoryCellDelegate: AnyObject {
    func onClick(model: HistoryModel) // Будет содержать в себе одну обязательную при использовании функцию
}

// Создаём элемент UIView который будет в себе содержать tableView с атрибутами и constraints(разметками), доступный для дальнейшего добавления в любой UIViewController
class HistoryTableView: UIView{

    private lazy var historyTableView: UITableView = { // Создаём UITableView с параметром private(чтобы был недоступен без нашего разрешения) и lazy(чтобы создавался только когда когда мы его используем и тем самым не нагружал систему)
        let view = UITableView() // Указываем тип нашей View
        view.delegate = self // Указываем что делегат(протокол управления(атрибуты)) нашего tableView равен самому себе
        view.dataSource = self // Указываем что dataSource(протокол заполнения данных) нашего tableView равен самому себе
        view.backgroundColor = .black // Указываем что фон будет черный(.black)
        view.register(HistoryCell.self, forCellReuseIdentifier: "HistoryCell") // Регистрируем нашу HistoryCell(клетку) из класса HistoryCell с идентификатором HistoryCell в наш tableView
        return view // Возвращаем наш tableView
    }()
    
    weak var delegate: HistoryCellDelegate? = nil // Указываем что изначально наш делегат для работы с клеткой ничего не имеет - тоесть nil

    override func layoutSubviews() { // Используем метод для указания разметок нашего UIView элемента
        addSubview(historyTableView) // Добавляем к нашему UIView сам tableView
        historyTableView.snp.makeConstraints { make in // Указываем констрейнты
            make.edges.equalToSuperview() // Указываем что все параметры размеров будут равны родителю(верх,низ,лево,право)
        }
    }
    
    private var models: Results<HistoryModel>? = nil // Создаем переменную которая будет хранить в себе все наши модели из Базы Данных (изначально nil)
    
    func fill(models: Results<HistoryModel>) { // Создаём функцию которая будет заполнять наш historyTableView нашими моделями
        self.models = models // Указываем что наши модели будут равны моделям указанным при использовании функции
        
        historyTableView.reloadData() // Обновляем данные в нашем historyTableView
    }
}

extension HistoryTableView: UITableViewDelegate, UITableViewDataSource { // Используем расширение для нашего HistoryTableView(UIView) чтобы иметь возможность указать параметры для нашего historyTableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models?.count ?? 0 // Указываем что если у нас есть модели, то количество рядов будет равно их количеству, если нет то 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { // Метод при нажатии на клетку
        if let model = models?[indexPath.row] { // Если модель есть, то использовать модель по соответствующему клетке индексу из БазыДанных
            delegate?.onClick(model: model) // Указываем что модель будет использована в методе onClick(нажатие) в нашей клетке
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = historyTableView.dequeueReusableCell(withIdentifier: "HistoryCell") as! HistoryCell // Указываем что клетка, показанная в historyTableView будет взята из класса HistoryCell с идентификатором "HistoryCell"
        
        if let model = models?[indexPath.row] { // Если модель есть, то использовать модель по соответствующему клетке индексу из БазыДанных
            cell.fill(model: model) // Заполняем нашу клетку по модели
        }
    
        return cell // Возвращаем нашу клетку
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100 // Указываем высоту клетки
    }
}
