//
//  CustomTableViewCell.swift
//  Calculator
//
//  Created by Ruslan Sharshenov on 07.02.2022.
//

import Foundation
import UIKit
import SnapKit

class CustomTableViewCell: UITableViewCell {

    lazy var title1: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 20, weight: .bold)
        view.adjustsFontSizeToFitWidth = true
        view.textAlignment = .left
        view.textColor = .white
        return view
    }()
    
    lazy var title2: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 15, weight: .bold)
        view.adjustsFontSizeToFitWidth = true
        view.textAlignment = .left
        view.textColor = .white
        return view
    }()
    
    override func layoutSubviews() {
        addSubview(title1)
        title1.snp.makeConstraints { make in
            make.top.width.equalToSuperview()
            make.height.equalToSuperview().dividedBy(2)
        }
        addSubview(title2)
        title2.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.top.equalTo(title1.snp.bottom)
            make.height.equalToSuperview().dividedBy(2)
        }
    }

}
