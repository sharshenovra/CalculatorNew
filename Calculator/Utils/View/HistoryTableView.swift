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
import SwiftUI

protocol HistoryCellDelegate: AnyObject {
    func onClick(model: HistoryModel)
}

class HistoryTableView: UIView{

    private lazy var historyTableView: UITableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        view.backgroundColor = .black
        view.register(HistoryCell.self, forCellReuseIdentifier: "HistoryCell")
        return view
    }()
    
    weak var delegate: HistoryCellDelegate? = nil

    override func layoutSubviews() {
        addSubview(historyTableView)
        historyTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private var models: Results<HistoryModel>? = nil
    
    func fill(models: Results<HistoryModel>) {
        self.models = models
        
        historyTableView.reloadData()
    }
}

extension HistoryTableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let model = models?[indexPath.row] {
            delegate?.onClick(model: model)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = historyTableView.dequeueReusableCell(withIdentifier: "HistoryCell") as! HistoryCell
        
        if let model = models?[indexPath.row] {
            cell.fill(model: model)
        }
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
