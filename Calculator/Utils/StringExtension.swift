//
//  StringExtension.swift
//  Calculator
//
//  Created by Ruslan Sharshenov on 06.02.2022.
//


import Foundation

extension String {

    private func allNumsToDouble() -> String {
        let symbolsCharSet = ".,"
        let fullCharSet = "0123456789" + symbolsCharSet
        var i = 0
        var result = ""
        var chars = Array(self)
        while i < chars.count {
            if fullCharSet.contains(chars[i]) {
                var numString = String(chars[i])
                i += 1
                loop: while i < chars.count {
                    if fullCharSet.contains(chars[i]) {
                        numString += String(chars[i])
                        i += 1
                    } else {
                        break loop
                    }
                }
                if let num = Double(numString) {
                    result += "\(num)"
                } else {
                    result += numString
                }
            } else {
                result += String(chars[i])
                i += 1
            }
        }
        return result
    }

    func calculate() -> Double? {
        let transformedString = allNumsToDouble()
        let expr = NSExpression(format: transformedString)
        return expr.expressionValue(with: nil, context: nil) as? Double
    }
}
