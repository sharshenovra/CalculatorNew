//
//  buttonModel.swift
//  Calculator
//
//  Created by Ruslan Sharshenov on 06.02.2022.
//

import Foundation
import UIKit

struct buttonModel{
    var title: String
    var titleColor: UIColor
    var color: UIColor
    
    init(_ title: String, _ titleColor: UIColor, _ color: UIColor){
        self.title = title
        self.titleColor = titleColor
        self.color = color
    }
}
