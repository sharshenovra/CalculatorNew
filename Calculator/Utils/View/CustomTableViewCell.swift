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

    private lazy var titlesView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        view.layer.cornerRadius = self.frame.height / 4
        return view
    }()
    
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
        super.layoutSubviews()

        contentView.clipsToBounds = true
        
        addSubview(titlesView)
        titlesView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(5)
        }
        
        titlesView.addSubview(title1)
        title1.snp.makeConstraints { make in
            make.top.width.equalToSuperview()
            make.height.equalToSuperview().dividedBy(2)
        }
        titlesView.addSubview(title2)
        title2.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.top.equalTo(title1.snp.bottom)
            make.height.equalToSuperview().dividedBy(2)
        }
    }

}
