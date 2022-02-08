//
//  HistoryViewController.swift
//  Calculator
//
//  Created by Ruslan Sharshenov on 07.02.2022.
//

import Foundation
import UIKit
import SnapKit
import RealmSwift

protocol HistorySelectDelegate: AnyObject {
    func selectHistory(model: HistoryModel)
}

class HistoryController: UIViewController{
    
    private lazy var historyTableView = HistoryTableView()
    
    private lazy var clearButton = CustomButton(title: "Clear all")
    private lazy var backButton = CustomButton(title: "Back")
    
    private lazy var viewModel: HistoryViewModel = {
        return HistoryViewModel(delegate: self)
    }()
    
    public static func newInstanse(delegate: HistorySelectDelegate) -> HistoryController {
        let controller = HistoryController()
        controller.viewModel.historyDelegate = delegate
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupConstraints()
        setupMainWindow()
        setupViews()
        
        viewModel.getHistory()
    }
    
    private func setupMainWindow() {
        view.backgroundColor = .black
    }
    
    func setupViews(){
        historyTableView.delegate = self
        
        backButton.setOnClickListener { view in
            self.navigationController?.popToRootViewController(animated: true)
        }
        
        clearButton.setOnClickListener { view in
            self.viewModel.deleteAllHistory()
        }
    }
    
    func setupConstraints(){
        view.addSubview(clearButton)
        clearButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeArea.top).offset(8)
            make.right.equalToSuperview().offset(-8)
        }
        
        view.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeArea.top).offset(8)
            make.left.equalToSuperview().offset(8)
        }
        
        view.addSubview(historyTableView)
        historyTableView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.top.equalTo(clearButton.snp.bottom)
            make.bottom.equalToSuperview()
        }
    }
    
}

extension HistoryController: HistoryCellDelegate {
    func onClick(model: HistoryModel) {
        viewModel.selecthistory(model: model)
        
        self.navigationController?.popViewController(animated: true)
    }
}

extension HistoryController: HistoryDelegate {
    func showHistory(model: Results<HistoryModel>) {
        historyTableView.fill(models: model)
    }
}
