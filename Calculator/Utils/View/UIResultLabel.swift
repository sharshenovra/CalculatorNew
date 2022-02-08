//
//  UIResultLabel.swift
//  Calculator
//
//  Created by Ruslan Sharshenov on 06.02.2022.
//

import Foundation
import UIKit
import SnapKit

// Создаём элемент UIView который будет в себе содержать 2 UILabel с атрибутами и constraints(разметками), доступный для дальнейшего добавления в любой UIViewController

class UIResultLabel: UIView { // Создаём класс UIView
    
    private lazy var mathLabel: UILabel = { // Создаём UILabel с параметром private(чтобы был недоступен без нашего разрешения) и lazy(чтобы создавался только когда когда мы его используем и тем самым не нагружал систему)
        let view = UILabel() // Указываем тип нашей View
        view.text = "0" // Указываем текст, который по умолчанию равен "0"
        view.textColor = .white // Указываем цвет текста, который по умолчанию равен .white "белый"
        view.font = UIFont.systemFont(ofSize: 34, weight: .bold) // Указываем что шрифт будет 34 размера жирный(.bold)
        view.adjustsFontSizeToFitWidth = true // Указываем что при нехватке ширины для введенного текста шрифт будет уменьшаться
        return view // Возвращаем наш view элемент в замыкании
    }()
    
    private lazy var resultMathLabel: UILabel = { // Создаём UILabel с параметром private(чтобы был недоступен без нашего разрешения) и lazy(чтобы создавался только когда когда мы его используем и тем самым не нагружал систему)
        let view = UILabel() // Указываем тип нашей View
        view.text = "0" // Указываем текст, который по умолчанию равен "0"
        view.textColor = .white // Указываем цвет текста, который по умолчанию равен .white "белый"
        view.font = UIFont.systemFont(ofSize: 24) // Указываем что шрифт будет 24 размера жирный(.bold)
        return view // Возвращаем наш view элемент в замыкании
    }()
    
    override func layoutSubviews() { // Используем метод для указания разметок нашего UIView элемента и добавления в него элементов
        addSubview(mathLabel) // Добавляем наш mathLabel к UIView
        mathLabel.snp.makeConstraints { make in // Указываем констрейнты
            make.height.equalTo(34) // Высота равна 34 пикселя
            make.top.equalToSuperview().offset(8) // Верх равен нашей UIView с отступом в 8 пикселей
            make.left.equalToSuperview().offset(8) // Слева равен нашей UIView с отступом в 8 пикселей
            make.right.equalToSuperview().offset(-8) // Справа равен нашей UIView с отступом в -8 пикселей
        }
        
        addSubview(resultMathLabel) // Добавляем наш resultMathLabel к UIView
        resultMathLabel.snp.makeConstraints { make in // Указываем констрейнты
            make.height.equalTo(24) // Высота равна 24 пикселя
            make.top.equalTo(mathLabel.snp.bottom).offset(8) // Верх равен нашей UIView с отступом в 8 пикселей
            make.left.equalToSuperview().offset(8) // Слева равен нашей UIView с отступом в 8 пикселей
            make.right.equalToSuperview().offset(-8) // Справа равен нашей UIView с отступом в -8 пикселей
            make.bottom.equalToSuperview().offset(-8) // Снизу равен нашей UIView с отступом в -8 пикселей
        }
        
        setupViews() // Используем нашу функцию setupViews() созданную ниже
    }
    
    private func setupViews() { // Создаём функцию setupViews()
        mathLabel.textAlignment = .right // Указываем что разметка текста в нашем mathLabel будет по правой стороне
        resultMathLabel.textAlignment = .right // Указываем что разметка текста в нашем resultMathLabel будет по правой стороне
    }
     
    func setMath(math: String) { // Создаём функцию setMath() которая будет принимать в себе String значение
        mathLabel.text = math // Указываем, что текст внутри нашего mathLabel будет равен тому, что мы введём внутри нашей функции
    }
    
    func setResult(result: String) { // Создаём функцию setResult() которая будет принимать в себе String значение
        resultMathLabel.text = result // Указываем, что текст внутри нашего resultMathLabel будет равен тому, что мы введём внутри нашей функции
    }
}
