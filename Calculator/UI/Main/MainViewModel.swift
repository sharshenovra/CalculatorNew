//
//  MainViewModel.swift
//  Calculator
//
//  Created by Ruslan Sharshenov on 06.02.2022.
//


import Foundation
import RealmSwift

protocol MainDelegate: AnyObject {
    func showMath(math: String)
    func showResult(result: String)
}

class MainViewModel {
    
    weak var delegate: MainDelegate? = nil
    
    init(delegate: MainDelegate) {
        self.delegate = delegate
    }
    
    private var math = "0"
    private var operators = ["+", "-", "*", "/", "."]
    private var realm = try! Realm()
    private var operations: Results<Calculations>!
    private var operation = false
    
    func clickButton(_ title: String) {
        let separatedArray = math.components(separatedBy: ["-", "*", "/", "+"])
        
        if title == "="{
            return
        }
        
        if title == "AC" {
            clearLast()
        }else if title == "%"{
            math = math + "*0.01*"
            calculatorMath(math)
        }else if title == "."{
            if separatedArray.last?.contains(".") == true{
                return
            }else{
                calculatemathResult(title)
            }
        } else if title == "C" {
            clearAll()
        } else if !(operators.contains(String(math.last ?? Character(""))) && operators.contains(title)) && operation == false{
            if title == "+" || title == "-" || title == "/" || title == "*"{
                operation = true
                calculatemathResult(title)
            }else{
                operation = false
                calculatemathResult(title)
            }
        }else if !(operators.contains(String(math.last ?? Character(""))) && operators.contains(title)) && operation == true {
            if title == "+" || title == "-" || title == "/" || title == "*"{
                return
            }else{
                operation = false
                calculatemathResult(title)
            }
        }
    }
    
    private func clearLast() {
        math = String(math.dropLast())
        
        if math.count == 0 {
            math = "0"
        }
        
        calculatorMath(math)
    }
    
    private func clearAll() {
        
        operations = realm.objects(Calculations.self)
        
        let operation = Calculations()
        if math != "0"{
            operation.operation = math
            let expr = NSExpression(format: math)
            let result = expr.expressionValue(with: nil, context: nil) as! Double
            let stringResult = String(result)
            let separatedArray = stringResult.components(separatedBy: ".")
            
            if separatedArray[1] == "0"{
                operation.result = separatedArray[0]
            }else{
                operation.result = stringResult
            }
            try! self.realm.write({
                self.realm.add(operation)
            })
        }
        
        math = "0"
        
        delegate?.showResult(result: "0")
        delegate?.showMath(math: "0")
    }
    
    private func calculatemathResult(_ title: String) {
        if (String(math.first ?? Character(""))) == "0" {
            math = String(math.dropFirst())
        }
        
        math = math + title
        
        calculatorMath(math)
    }
    
    private func calculatorMath(_ math: String) {
        if !operators.contains(String(math.last ?? Character(""))) {
            let expr = NSExpression(format: math)
            let result = expr.expressionValue(with: nil, context: nil) as! Double
            let stringResult = String(result)
            let separatedArray = stringResult.components(separatedBy: ".")
            
            if separatedArray[1] == "0"{
                delegate?.showResult(result: "\(separatedArray[0])")
            }else{
                delegate?.showResult(result: stringResult)
            }
        } else {
            delegate?.showResult(result: "0")
        }
        
        delegate?.showMath(math: math)
    }
}
