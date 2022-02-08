//
//  UIButtonsLayoutView.swift
//  Calculator
//
//  Created by Ruslan Sharshenov on 06.02.2022.
//

import Foundation
import UIKit
import SnapKit

// Создаём протокол(обязательное условие при его использовании)
protocol UIButtonsLayoutDelegate: AnyObject {
    func onClickButton(title: String) // Будет содержать в себе одну обязательную при использовании функцию
}

// Создаём элемент UIView который будет в себе содержать все наши кнопки с атрибутами и constraints(разметками), доступный для дальнейшего добавления в любой UIViewController
class UIButtonsLayoutView: UIView {
    
    private lazy var horizontqalSteck: UIStackView = { // Создаём UIStackView с параметром private(чтобы был недоступен без нашего разрешения) и lazy(чтобы создавался только когда когда мы его используем и тем самым не нагружал систему)
        let view = UIStackView() // Указываем тип нашей View
        view.axis = .vertical // Указываем что наш стек будет содержать в себе элементы расположенные по вертикали(ось Y)
        view.spacing = 8 // Указываем что промежуток между элементами будет равен 8 пикселям
        view.distribution = .fillEqually // Указываем что элементы находящиеся внутри нашего стека будут заполнены равномерно
        return view // Возвращаем наш стек в замыкании
    }()
    
    public weak var delegate: UIButtonsLayoutDelegate? = nil // Создаём переменную public(чтобы была доступна в любом классе) и weak(чтобы даже если что-то произойдёт эта переменная продолжала существовать)
    
    private let buttons = [ // Создаём переменную с параметром private(чтобы был недоступен без нашего разрешения) которая содержит в себе двухмерный массив содержащий наши кнопки заданные по модели ButtonModel
        [ButtonModel("AC", .black, .gray), ButtonModel("%", .black, .gray), ButtonModel("C", .black, .gray), ButtonModel("/", .white, .orange)],
        [ButtonModel("7", .white, .darkGray), ButtonModel("8", .white, .darkGray), ButtonModel("9", .white, .darkGray), ButtonModel("*", .white, .orange)],
        [ButtonModel("4", .white, .darkGray), ButtonModel("5", .white, .darkGray), ButtonModel("6", .white, .darkGray), ButtonModel("-", .white, .orange)],
        [ButtonModel("1", .white, .darkGray), ButtonModel("2", .white, .darkGray), ButtonModel("3", .white, .darkGray), ButtonModel("+", .white, .orange)],
    ]
    
    private func secontStart(_ cornerRadius: Double) { // Создаём функцию которая будет создавать на экране наш StackView с элементами
        buttons.forEach { buttonsItem in // Используем цикл в массиве (цикл сработает 4 раза, так как это двухмерный массив, содержащий в себе 4 массива)
            let stack = crateStack() // Создаём первый стек (в итоге 4)
            
            buttonsItem.forEach { item in // Используем цикл в массиве (для каждого из четырёх) для добавления наших кнопок в соответствующий стек
                stack.addArrangedSubview(createButton(model: item, cornerRadius)) // Добавляем кнопку в стек
            }
            
            self.horizontqalSteck.addArrangedSubview(stack) // Добавляем наш стек в первоначально созданный стек
        }
         
        let left = crateStack() // Создаём стек left
        let rithe = crateStack() // Создаём стек rithe
        
        let sumStack = crateStack() // Создаём общий стек который будет в себе содержать left и rithe стеки
        
        left.addArrangedSubview(createButton(model: ButtonModel("0", .white, .darkGray), cornerRadius)) // добавляем кнопку "0" в наш стек left
        sumStack.addArrangedSubview(left) // Добавляем наш left стек в общий стек

        rithe.addArrangedSubview(createButton(model: ButtonModel(".", .white, .darkGray), cornerRadius)) // добавляем кнопку "." в наш стек rithe
        rithe.addArrangedSubview(createButton(model: ButtonModel("=", .white, .orange), cornerRadius)) // добавляем кнопку "=" в наш стек rithe
        
        sumStack.addArrangedSubview(rithe) // Добавляем наш rithe стек в общий стек
        
        horizontqalSteck.addArrangedSubview(sumStack) // Добавляем наш общий стек в изначально созданный стек стек
    }
    
    func createButtonLayouts(cornerRadius: Double) { // Создаём функцию которая будет добавлять все элементы прописанные выше там, где понадобится
        addSubview(horizontqalSteck) // Добавляем наш изначально созданный стек
        horizontqalSteck.snp.makeConstraints { make in // Указываем констрейнты для нашего изначально созданного стека
            make.top.equalToSuperview().offset(8) // Указываем что сверху он будет равен родителю с отступом в 8 пикселей
            make.left.equalToSuperview().offset(8) // Указываем что слева он будет равен родителю с отступом в 8 пикселей
            make.right.equalToSuperview().offset(-8) // Указываем что справа он будет равен родителю с отступом в -8 пикселей
            make.bottom.equalToSuperview().offset(-8) // Указываем что снизу он будет равен родителю с отступом в -8 пикселей
        }
        
        secontStart(cornerRadius) // Теперь, после добавления нашего общего стека используем нашу функцию которая добавит все кнопки и стеки в наш изначально созданный стек
    }
    
    // Создаём функцию с параметром private которая будет создавать кнопку по модели ButtonModel с указанным cornerRadius(закругление краёв)
    private func createButton(model: ButtonModel, _ cornerRadius: Double) -> UIButton {
        let view = UIButton(type: .system) // Указываем что наша view будет типа UIButton(кнопка) с параметром типа ".system"(чтобы было видно нажатие)
        view.addTarget(self, action: #selector(clickButtons(view:)), for: .touchUpInside) // Добавляем для нашей кнопки действие clickButtons при нажатии touchUpInside (нажать и отпустить)
        view.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .bold) // Указываем что шрифт для нашего текста кнопки будет размера 30 и жирный (.bold)
        view.setTitle(model.title, for: .normal) // Указываем что текст в нашей кнопке будет взят из модели из переменной title
        view.layer.cornerRadius = (cornerRadius / 2.0) - 8 // Указываем что cornerRadius будет равен указанному cornerRadius разделённому на 2 и минус 8(отступ между кнопками)
        view.backgroundColor = model.color // Указываем что цвет фона  в нашей кнопке будет взят из модели из переменной color
        view.setTitleColor(model.titleColor, for: .normal) // Указываем что цвет текста в нашей кнопке будет взят из модели из переменной titleColor
        return view // Созвращаем нашу кнопку в замыкании
    }
    
    // Создаём функцию которая будет создавать стек
    private func crateStack() -> UIStackView { // Указываем что функция будет возвращать стек
        let view = UIStackView() // Указываем что наш view будет типа UIStackView(стек)
        view.axis = .horizontal // Указываем что элементы в нём будут расположены по горизонтали(ось Х)
        view.spacing = 8 // Указываем что отступ между элементами будет равен 8 пикселям
        view.distribution = .fillEqually// Указываем что элементы находящиеся внутри нашего стека будут заполнены равномерно
        return view // Возвращаем наш стек в замыкании
    }
    
    // Создаём функцию которая будет отвечать за действие при нажатии на кнопку
    @objc func clickButtons(view: UIButton) { // Функция принимает в себе UIButton
        delegate?.onClickButton(title: view.titleLabel?.text ?? String()) // Указываем что будет использоваться функция onClickButton, прописанная в MainViewModel отвечающая за нажатие на кнопку и будет принимать в себе текст внутри нашей кнопки (если его нет, то пустое значение)
    }
}
