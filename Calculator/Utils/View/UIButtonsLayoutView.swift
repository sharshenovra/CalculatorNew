//
//  UIButtonsLayoutView.swift
//  Calculator
//
//  Created by Ruslan Sharshenov on 06.02.2022.
//

import Foundation
import UIKit
import SnapKit

protocol UIButtonsLayoutDelegate: AnyObject {
    func onClickButton(title: String)
}

class UIButtonsLayoutView: UIView {
    
    private lazy var horizontqalSteck: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 8
        view.distribution = .fillEqually
        return view
    }()
    
    public weak var delegate: UIButtonsLayoutDelegate? = nil
    
    private let buttons = [
        [buttonModel("AC", .black, .gray), buttonModel("%", .black, .gray), buttonModel("C", .black, .gray), buttonModel("/", .white, .orange)],
        [buttonModel("7", .white, .darkGray), buttonModel("8", .white, .darkGray), buttonModel("9", .white, .darkGray), buttonModel("*", .white, .orange)],
        [buttonModel("4", .white, .darkGray), buttonModel("5", .white, .darkGray), buttonModel("6", .white, .darkGray), buttonModel("-", .white, .orange)],
        [buttonModel("1", .white, .darkGray), buttonModel("2", .white, .darkGray), buttonModel("3", .white, .darkGray), buttonModel("+", .white, .orange)],
    ]
    
    private func secontStart(_ cornerRadius: Double) {
        buttons.forEach { buttonsItem in
            let stack = crateStack()
            
            buttonsItem.forEach { item in
                stack.addArrangedSubview(createButton(model: item, cornerRadius))
            }
            
            self.horizontqalSteck.addArrangedSubview(stack)
        }
         
        let left = crateStack()
        let rithe = crateStack()
        
        let sumStack = crateStack()
        
        left.addArrangedSubview(createButton(model: buttonModel("0", .white, .darkGray), cornerRadius))
        sumStack.addArrangedSubview(left)

        rithe.addArrangedSubview(createButton(model: buttonModel(".", .white, .darkGray), cornerRadius))
        rithe.addArrangedSubview(createButton(model: buttonModel("=", .white, .orange), cornerRadius))
        
        sumStack.addArrangedSubview(rithe)
        
        horizontqalSteck.addArrangedSubview(sumStack)
    }
    
    func createButtonLayouts(cornerRadius: Double) {
        addSubview(horizontqalSteck)
        horizontqalSteck.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().offset(-8)
            make.bottom.equalToSuperview().offset(-8)
        }
        
        secontStart(cornerRadius)
    }
    
    private func createButton(model: buttonModel, _ cornerRadius: Double) -> UIButton {
        let view = UIButton(type: .system)
        view.addTarget(self, action: #selector(clickButtons(view:)), for: .touchUpInside)
        view.titleLabel?.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        view.setTitle(model.title, for: .normal)
        view.layer.cornerRadius = (cornerRadius / 2.0) - 8
        view.backgroundColor = model.color
        view.setTitleColor(model.titleColor, for: .normal)
        return view
    }
    
    private func crateStack() -> UIStackView {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 8
        view.distribution = .fillEqually
        return view
    }
    
    @objc func clickButtons(view: UIButton) {
        delegate?.onClickButton(title: view.titleLabel?.text ?? String())
    }
}
