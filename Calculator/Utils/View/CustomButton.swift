//
//  CustomButton.swift
//  Calculator
//
//  Created by Ruslan Sharshenov on 07.02.2022.
//

import Foundation
import UIKit

class CustomButton: UIButton {

    private var onClick: (CustomButton) -> Void = { _ in }
    
    init(title: String) {
        super.init(frame: .zero)
        
        setTitle(title, for: .normal)
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setOnClickListener(onClick: @escaping (CustomButton) -> Void) {
        self.onClick = onClick
        
        addTarget(nil, action: #selector(clickButton(view:)), for: .touchUpInside)
    }
    
    @objc func clickButton(view: UIButton) {
        onClick(self)
    }
}
