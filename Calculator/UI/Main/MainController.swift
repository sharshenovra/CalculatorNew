//
//  ViewController.swift
//  Calculator
//
//  Created by Ruslan Sharshenov on 06.02.2022.
//

import UIKit
import SnapKit

class MainController: UIViewController {

    private lazy var resultLabel = UIResultLabel()
    private lazy var buttonsLayout = UIButtonsLayoutView()
    private lazy var historyButton: CustomButton = {
        let view = CustomButton(type: .system)
        view.setTitle("History", for: .normal)
        view.setTitleColor(.red, for: .normal)
        return view
    }()
    
    let rootVC = HistoryViewController()
    
    private lazy var viewmodel: MainViewModel = {
        return MainViewModel(delegate: self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupMainWindow()
        setupViews()
     
        historyButton.setOnClickListener { view in
            self.navigationController?.pushViewController(self.rootVC, animated: true)
        }
    }
    
    private func setupMainWindow() {
        view.backgroundColor = .black
    }
    
    private func setupViews() {
        buttonsLayout.delegate = self
        
        view.addSubview(historyButton)
        historyButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeArea.top)
            make.right.equalToSuperview()
        }
        
        view.addSubview(buttonsLayout)
        buttonsLayout.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeArea.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo((self.view.frame.width / 4.0) * 5)
        }
        
        buttonsLayout.createButtonLayouts(cornerRadius: ((self.view.frame.width / 4.0)))
        
        view.addSubview(resultLabel)
        resultLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalTo(buttonsLayout.snp.top).offset(-16)
        }
    }
}

extension MainController: UIButtonsLayoutDelegate {
    func onClickButton(title: String) {
        viewmodel.clickButton(title)
    }
}

extension MainController: MainDelegate {
    func showMath(math: String) {
        resultLabel.setMath(math: math)
    }
    
    func showResult(result: String) {
        resultLabel.setResult(result: result)
    }
}


