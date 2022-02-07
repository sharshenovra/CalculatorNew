//
//  HistoryTableView.swift
//  Calculator
//
//  Created by Ruslan Sharshenov on 07.02.2022.
//

import Foundation
import UIKit
import SnapKit
import RealmSwift

class HistoryTableView: UIView{

    lazy var historyTableView: UITableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    
    let dataBase = DataBase()
    
    let realm = try! Realm()
    
    var calculations = DataBase.shared.calculations
    
    override func layoutSubviews() {
        addSubview(historyTableView)
        historyTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        historyTableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "CustomTableViewCell")
    }
    
}



extension HistoryTableView: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        calculations = realm.objects(Calculations.self)
        return calculations!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        calculations = realm.objects(Calculations.self)
        let calculation = calculations![indexPath.row]
        let cell = historyTableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell") as! CustomTableViewCell
        cell.title1.text = calculation.operation
        cell.title2.text = calculation.result
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
