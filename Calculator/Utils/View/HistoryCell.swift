//
//  CustomTableViewCell.swift
//  Calculator
//
//  Created by Ruslan Sharshenov on 07.02.2022.
//

import Foundation
import UIKit
import SnapKit

class HistoryCell: UITableViewCell { // Создаём нашу клетку
    
    lazy var mathLabel: UILabel = { // Создаём лейбл для нашей клетки, который будет содержать в себе математическое выражение
        let view = UILabel() // Указываем типа нашей view 
        view.font = .systemFont(ofSize: 30, weight: .bold)  // Указываем что шрифт будет 30 размера жирный(.bold)
        view.adjustsFontSizeToFitWidth = true // Указываем что при нехватке ширины для введенного текста шрифт будет уменьшаться
        view.textAlignment = .left  // Указываем что разметка текста в нашем mathLabel будет по левой стороне
        view.textColor = .white // Указываем цвет текста, который по умолчанию равен .white "белый"
        return view // Возвращаем наш view элемент в замыкании
    }()
    
    lazy var resultLabel: UILabel = { // Создаём лейбл для нашей клетки, который будет содержать в себе результат математического выражения
        let view = UILabel() // Указываем типа нашей view
        view.font = .systemFont(ofSize: 22, weight: .bold)  // Указываем что шрифт будет 22 размера жирный(.bold)
        view.adjustsFontSizeToFitWidth = true // Указываем что при нехватке ширины для введенного текста шрифт будет уменьшаться
        view.textAlignment = .left  // Указываем что разметка текста в нашем resultLabel будет по левой стороне
        view.textColor = .white // Указываем цвет текста, который по умолчанию равен .white "белый"
        return view // Возвращаем наш view элемент в замыкании
    }()
    
    override func layoutSubviews() { // Используем метод для указания разметок нашего UIView элемента и добавления в него элементов
        addSubview(mathLabel) // Добавляем наш mathLabel к UIView
        mathLabel.snp.makeConstraints { make in // Указываем констрейнты
            make.top.equalToSuperview().offset(8) // Верх равен нашей UIView с отступом в 8 пикселей
            make.left.equalToSuperview().offset(8) // Слева равен нашей UIView с отступом в 8 пикселей
            make.right.equalToSuperview().offset(-8) // Справа равен нашей UIView с отступом в 8 пикселей
        }

        addSubview(resultLabel) // Добавляем наш resultMathLabel к UIView
        resultLabel.snp.makeConstraints { make in // Указываем констрейнты
            make.bottom.equalToSuperview().offset(-8) // Снизу равен нашей UIView с отступом в -8 пикселей
            make.left.equalToSuperview().offset(8) // Слева равен нашей UIView с отступом в 8 пикселей
            make.right.equalToSuperview().offset(-8)// Справа равен нашей UIView с отступом в -8 пикселей
        }
    }

    func fill(model: HistoryModel) { // Создаём функцию которая будет принимать в себе модель наших вычеслений
        mathLabel.text = model.math // Указываем что текст внутри mathLabel будет равен math из нашей модели
        resultLabel.text = model.result// Указываем что текст внутри resultLabel будет равен result из нашей модели
    }
}
