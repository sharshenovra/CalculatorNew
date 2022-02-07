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

class HistoryViewController: UIViewController{
    
    private lazy var tableView = HistoryTableView()
    
    private lazy var clearButton: CustomButton = {
        let view = CustomButton(type: .system)
        view.setTitle("Очистить", for: .normal)
        view.setTitleColor(.red, for: .normal)
        return view
    }()
    
    private lazy var backButton: CustomButton = {
        let view = CustomButton(type: .system)
        view.setTitle("Назад", for: .normal)
        view.setTitleColor(.red, for: .normal)
        return view
    }()
    
    let realm = try! Realm()
    
    var calculations = DataBase.shared.calculations
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupConstraints()
        setupTableView()
        setupViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupTableView()
        
    }
    
    func setupViews(){
        
        backButton.setOnClickListener { view in
            self.navigationController?.popToRootViewController(animated: true)
        }
        
        clearButton.setOnClickListener { view in
           try! self.realm.write{
                self.realm.deleteAll()
            }
            self.tableView.historyTableView.reloadData()
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    func setupTableView(){
        calculations = realm.objects(Calculations.self)
        
        self.tableView.historyTableView.reloadData()
        
    }
    
   func setupConstraints(){
       view.addSubview(clearButton)
       clearButton.snp.makeConstraints { make in
           make.top.equalTo(view.safeArea.top)
           make.right.equalToSuperview()
       }
       view.addSubview(backButton)
       backButton.snp.makeConstraints { make in
           make.top.equalTo(view.safeArea.top)
           make.left.equalToSuperview()
       }
       view.addSubview(tableView)
       tableView.snp.makeConstraints { make in
           make.width.equalToSuperview()
           make.top.equalTo(clearButton.snp.bottom)
           make.bottom.equalToSuperview()
       }
    }
    
}
