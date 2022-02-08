//
//  ViewController.swift
//  Calculator
//
//  Created by Ruslan Sharshenov on 06.02.2022.
//

import UIKit
import SnapKit

// Создаём наш главный Контроллер
class MainController: UIViewController {

    private lazy var resultLabel = UIResultLabel() // Создаём resultLabel из ранее созданной UIResultLabel
    private lazy var buttonsLayout = UIButtonsLayoutView() // Создаём buttonsLayout из ранее созданной UIButtonsLayoutView
    private lazy var historyButton = CustomButton(title: "History")  // Создаём historyButton(енопку) из ранее созданной CustomButton с title "History"
    
    private lazy var viewmodel: MainViewModel = { // Создаём переменную которая будет содержать в себе нашу модель
        return MainViewModel(delegate: self) // Возвращаем нашу модель с использованием её делегата
    }()
    
    override func viewDidLoad() { // Метод который используется при создании экрана
        super.viewDidLoad() // Bспользуем метод Swift

        setupMainWindow() // Осуществляем реализацию функции описанной ниже
        setupViews() // Осуществляем реализацию функции описанной ниже

    }
    
    private func setupMainWindow() { // Создаём функцию которая будет менять фон
        view.backgroundColor = .black // Указываем что фон будет черный(.black)
    }
    
    private func setupViews() { // Создаём функцию которая будет отвечать за разметку и параметры наших элементов
        buttonsLayout.delegate = self // Указываем что наши кнопки будут использовать собственный делегат
        
        view.addSubview(historyButton) // Добавляем historyButton в наш контроллер
        historyButton.snp.makeConstraints { make in // Задаем констрейнты
            make.top.equalTo(view.safeArea.top).offset(8) // Указываем что верх нашей кнопки будет в безопасном месте сверху с отступом в 8 пикселей
            make.right.equalToSuperview().offset(-8) // Указываем что справа она будет привязана к родителю с отступом в -8 пикселей
        }
        
        view.addSubview(buttonsLayout) // Добавляем buttonsLayout в наш контроллер
        buttonsLayout.snp.makeConstraints { make in // Задаем констрейнты
            make.bottom.equalTo(view.safeArea.bottom) // Указываем что низ наших кнопок будет в безопасном месте снизу
            make.left.right.equalToSuperview() // Указываем что слева и справа он будет равен родителю
            make.height.equalTo((self.view.frame.width / 4.0) * 5) // указываем что ширина наших кнопок будет равна родителю деленному на 4 и умноженному на 5
        }
        
        buttonsLayout.createButtonLayouts(cornerRadius: ((self.view.frame.width / 4.0))) // Создаём наши кнопки с cornerRadius равным ширине деленной на 4
        
        view.addSubview(resultLabel) // Добавляем наш resultLabel в контроллер
        resultLabel.snp.makeConstraints { make in // Задаем констрейнты
            make.left.right.equalToSuperview() // Указываем что слева и справа он будет равен родителю
            make.bottom.equalTo(buttonsLayout.snp.top).offset(-16) // Указываем что наш лейбл будет снизу привязан к верху кнопок с отступом в -16 пикселей
        }
        
        historyButton.setOnClickListener { view in // Создаём действие для нашей кнопки historyButton используя метод setOnClickListener прописанный в CustomButton
            self.navigationController?.pushViewController(HistoryController.newInstanse(delegate: self), animated: true) // Указываем что будет совершен переход на HistoryController с использованием его делегата с анимацией
        }
    }
}

extension MainController: HistorySelectDelegate { // Используем расширение для использования делегата HistorySelectDelegate
    func selectHistory(model: HistoryModel) { // Используем функцию которая будет срабатывать при нажатии на ячейку
        viewmodel.selectHistory(model: model) // Указываем что выбранная клетка будет соответствовать нашей модели указанной при использовании функции
    }
}

extension MainController: UIButtonsLayoutDelegate { // Используем расширение для использования делегата UIButtonsLayoutDelegate
    func onClickButton(title: String) { // Используем функцию которая будет срабатывать при нажатии на кнопку
        viewmodel.clickButton(title) // Указываем что при нажатии на кнопку будет срабатывать метод clickButton прописанный в MainViewModel с title из нашей модели
    }
}

extension MainController: MainDelegate { // Используем расширение для использования делегата MainDelegate
    func showMath(math: String) { // Используем функцию которая будет отображать математическое выражение
        resultLabel.setMath(math: math) // Указываем что title для нашего resultLabel будет задан с использованием функции setMath прописанной в UIResultLabel с математическим выражением указанным в math при использовании функции
    }
    
    func showResult(result: String) { // Используем функцию которая будет отображать результат математического выражения
        resultLabel.setResult(result: result) // Указываем что result для нашего resultLabel будет задан с использованием функции setResult прописанной в UIResultLabel с математическим выражением указанным в math при использовании функции
    }
}


