//
//  buttonModel.swift
//  Calculator
//
//  Created by Ruslan Sharshenov on 06.02.2022.
//

import Foundation
import UIKit

//Модель по которой в дальнейшнем создается кнопка

struct ButtonModel{ // Создаем структуру "ButtonModel"
    var title: String // Задаем переменную title типа String
    var titleColor: UIColor // Задаем переменную titleСolor типа UIColor
    var color: UIColor // Задаем переменную color типа UIColor
    
    
    // Создаем инициализатор который будет в дальнейшем использоваться как конструктор приёмных данных параметров кнопки
    init(_ title: String, _ titleColor: UIColor, _ color: UIColor){ // Указываем в инициализатор параметры для приёма
        self.title = title // Указываем что title в кнопке будет равен title указанный в инициализоре
        self.titleColor = titleColor // Указываем что titleColor в кнопке будет равен titleColor указанный в инициализоре
        self.color = color // Указываем что color в кнопке будет равен color указанный в инициализоре
    }
}
