//
//  CustomTableViewCell.swift
//  Calculator
//
//  Created by Ruslan Sharshenov on 07.02.2022.
//

import Foundation
import UIKit
import SnapKit

class HistoryCell: UITableViewCell {
    
    lazy var mathLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 30, weight: .bold)
        view.adjustsFontSizeToFitWidth = true
        view.textAlignment = .left
        view.textColor = .white
        return view
    }()
    
    lazy var resultLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 22, weight: .bold)
        view.adjustsFontSizeToFitWidth = true
        view.textAlignment = .left
        view.textColor = .white
        return view
    }()
    
    override func layoutSubviews() {
        addSubview(mathLabel)
        mathLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().offset(-8)
        }

        addSubview(resultLabel)
        resultLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-8)
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().offset(-8)
        }
    }

    func fill(model: HistoryModel) {
        mathLabel.text = model.math
        resultLabel.text = model.result
    }
}
