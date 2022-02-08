//
//  CustomButton.swift
//  Calculator
//
//  Created by Ruslan Sharshenov on 07.02.2022.
//

import Foundation
import UIKit

// Создаём нашу кастомную кнопку
class CustomButton: UIButton {

    private var onClick: (CustomButton) -> Void = { _ in } // Создаем переменную которая будет принимать в себе кнопку и исполнять блок кода внутри себя
    
    init(title: String) { // Используем инициализатор для указания текста(title) для нашей клетки
        super.init(frame: .zero) // Используем инициализтор Swift 
        
        setTitle(title, for: .normal) // Указываем что title внутри нашей кнопки будет равен тому title который мы укажем в инициализаторе
        setTitleColor(.white, for: .normal) // Указываем что цвет текста будет по умолчанию белого цвета (.white)
        titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold) // Указываем что шрифт нашего текста внутри кнопки будет по умолчанию размера 20 и жирный(.bold)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }// Ошибка если инициализатор не был использован
    
    func setOnClickListener(onClick: @escaping (CustomButton) -> Void) { // Создаём функцию которая будет отвечать за действие при нажатии на кнопку
        self.onClick = onClick // Указываем что ранее созданная переменная onClick будет равна onClick которая указана при использовании функции
        
        addTarget(nil, action: #selector(clickButton(view:)), for: .touchUpInside) // Добавляем действие clickButton для кнопки при нажатии touchUpInside (нажать и отпустить)
    }
    
    @objc func clickButton(view: UIButton) { // Создаём функцию которая будет выполняться при добавлении действия
        onClick(self) // Указываем что при нажатии на кнопку будет срабатывать код, прописанный в методе onClick
    }
}
