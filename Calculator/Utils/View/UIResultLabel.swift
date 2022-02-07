//
//  UIResultLabel.swift
//  Calculator
//
//  Created by Ruslan Sharshenov on 06.02.2022.
//

import Foundation
import UIKit
import SnapKit

class UIResultLabel: UIView {
    
    private lazy var mathLabel: UILabel = {
        let view = UILabel()
        view.text = "0"
        view.textColor = .white
        view.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        view.adjustsFontSizeToFitWidth = true
        return view
    }()
    
    private lazy var resultMathLabel: UILabel = {
        let view = UILabel()
        view.text = "0"
        view.textColor = .white
        view.font = UIFont.systemFont(ofSize: 24)
        return view
    }()
    
    override func layoutSubviews() {
        addSubview(mathLabel)
        mathLabel.snp.makeConstraints { make in
            make.height.equalTo(34)
            make.top.equalToSuperview().offset(8)
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().offset(-8)
        }
        
        addSubview(resultMathLabel)
        resultMathLabel.snp.makeConstraints { make in
            make.height.equalTo(24)
            make.top.equalTo(mathLabel.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().offset(-8)
            make.bottom.equalToSuperview().offset(-8)
        }
        
        setupViews()
    }
    
    private func setupViews() {
        mathLabel.textAlignment = .right
        resultMathLabel.textAlignment = .right
    }
     
    func setMath(math: String) {
        mathLabel.text = math
    }
    
    func setResult(result: String) {
        resultMathLabel.text = result
    }
}
