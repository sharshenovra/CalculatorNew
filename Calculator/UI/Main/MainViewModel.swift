//
//  MainViewModel.swift
//  Calculator
//
//  Created by Ruslan Sharshenov on 06.02.2022.
//


import Foundation
import RealmSwift

// Создаём протокол(обязательное условие при его использовании) который будет содержать в себе две обязательные при использовании функции
protocol MainDelegate: AnyObject {
    func showMath(math: String) // Показывать математическое выражение
    func showResult(result: String) // Показывать его результат
}

// Создаём нашу ViewModel которая будет отвечать за логику между контроллером и UI-элементаим
class MainViewModel {
    
    weak var delegate: MainDelegate? = nil  // Создаём переменную weak(чтобы даже если что-то произойдёт эта переменная продолжала существовать) которая будет давать нам доступ к методам делегата
    
    init(delegate: MainDelegate) { // Создаём инициализатор который будет в себе принимать протокол
        self.delegate = delegate // Протокол созданный ранее будет равен указанному при использовании переменной
    }
    
    private var math = "0" // Создаём переменную которая будет хранить в себе математическое выражение, изначально равно "0"
    private var operators = ["+", "-", "*", "/", "."] // Создаём переменную которая будет хранить в себе математические операторы и "."
    private var operation = false // Создаём переменную которая будет хранить в себе булевое значение отвечающее за нажатие на оператор
    
    func selectHistory(model: HistoryModel) { // Создаём функцию которая будет отвечать за нажатие на кнопку
        math = model.math // Указываем что математическое выражение в нашем math будет равно math из модели указанной при использовании функции
        operation = false // Указываем что при нажатии операция будет возвращена в значение false
        
        delegate?.showMath(math: model.math) // Используем делегат чтобы использовать функцию которая назначит для mathLabel значение из math нашей модели
        delegate?.showResult(result: model.result)// Используем делегат чтобы использовать функцию которая назначит для resultLabel значение из result нашей модели
    }
    
    func clickButton(_ title: String) { // Создаём функцию которая будет отвечать за действия происходящие при нажатии на кнопку
        let separatedArray = math.components(separatedBy: ["-", "*", "/", "+"]) // Разделяем наше математическое выражение на числа путём отделения их от операторов
        
        if title == "="{ // Если нажата кнопка "="
            return // Ничего не делать
        }
        
        if title == "AC" { // Если нажата кнопка "AC"
            clearLast() // Используем функцию описанную ниже убирающую последний элемент
        }else if title == "%"{ // Если нажата кнопка "5"
            math += "*0.01*" // Добавляем к нашему математическому выражению "*0.01"
            calculatorMath(math) // Считаем результат и выдаём его в наш resultLabel используя функцию calculatorMath описанную ниже с параметром math
        }else if title == "."{ // Если нажата кнопка "."
            if separatedArray.last?.contains(".") == true{ // Если последний элемент из нашего разделенного массива (последнее число) содержит "."
                return // Ничего не делать
            }else{
                calculatemathResult(title) // Добавляем "." к мат.выражению и считаем результат
            }
        } else if title == "C" { // Если нажата кнопка "С"
            clearAll() // Используем функцию описанную ниже очищающую mathTitle и resultTitle
        } else if !(operators.contains(String(math.last ?? Character(""))) && operators.contains(title)){ // Если операторы не содержат последний нажатый оператор и оператор содержит title нашей кнопки
            if title == "+" || title == "-" || title == "/" || title == "*"{ // Если нажат оператор
                if operation == false{ // Если операция ранее не была нажата
                    operation = true // Операция нажата = true
                    calculatemathResult(title) // Добавляем оператор в math и считаем результат
                }else if operation == true{ // Если операция нажата до этого
                    return // Не делать ничего
                }
            }else{ // Если выше не сработало(нажата кнопка операнд) (цифры)
                operation = false // Операцию возвращаем в значение false
                calculatemathResult(title) // Добавляем к math и считаем результат
            }
        }
    }
    
    private func clearLast() { // Создаём функцию которая удаляет последний элемент
        math = String(math.dropLast()) // Используем функцию dropLast для удаления последнего элемента
        
        if math.count == 0 { // Если количество символов становится 0
            math = "0" // math возвращается в значение "0"
        }
        
        calculatorMath(math) // Считаем результат от нашего math
    }
    
    private func clearAll() { // Создаём функцию которая всё очищает
        math = "0" // math возвращается в значение "0"
        
        delegate?.showResult(result: "0") // Используя делегат задаем текст в resultLabel "0"
        delegate?.showMath(math: "0") // Используя делегат задаем текст в mathLabel "0"
    }
    
    private func calculatemathResult(_ title: String) { // Создаём функцию которая будет добавлять title нажатой кнопки в math и считать результат
        if (String(math.first ?? Character(""))) == "0" { // Проверяем, не равен ли наш math "0"
            math = String(math.dropFirst()) // Удаляем "0", тоесть первый элемент используя функцию dropFirst
        }
        
        math += title // Добавляем в math - title нажатой кнопки
        
        calculatorMath(math) // Считаем наш результат и выводим его на экран
    }
    
    private func calculatorMath(_ math: String) { // Создаём функцию которая будет считать результат
        if !operators.contains(String(math.last ?? Character(""))) { // Если последний элемент не является операцией(тоесть выражение заканчивается числом)
            let expr = NSExpression(format: math) // Создаём переменную которая будет конвертировать math в тип NSExpression для дальнейшего подсчета
            let result = expr.expressionValue(with: nil, context: nil) as! Double // Указываем что результат будет типа Double
            let stringResult = String(result) // Создаём переменную которая конвертирует Double результат в String
            let separatedArray = stringResult.components(separatedBy: ".") // Делим наш разделенный по "."
            
            DataBase.shared.saveHistory(model: HistoryModel.createHistory(math: math, result: stringResult)) // Сохраняем наше выражение в историю
            
            if separatedArray[1] == "0"{ // Если после "." нет числа, т.е чисто без истатка
                delegate?.showResult(result: "\(separatedArray[0])") // Используем делегат чтобы показать результат без запятой
            }else{ // Если после "." есть число
                delegate?.showResult(result: stringResult) // Показываем изначальный результат до разделения
            }
        } else { // Если последний элемент это оператор
            delegate?.showResult(result: "0") // Используя делегат оказываем в resultLabel "0"
        }
        
        delegate?.showMath(math: math) // Используя делегат показываем выражение math
    }
}
