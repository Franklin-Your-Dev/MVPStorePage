//
//  faceTableViewCell.swift
//  MVPStorePage
//
//  Created by Franklin Gaspar on 27/02/22.
//

import UIKit

protocol DynamicInsertDelegate {
    func added()
}

class FaceTableViewCell: UITableViewCell {
    
    var myTableView = InnerTableView()
    var delegate: DynamicInsertDelegate?
    var list = ["1","2", "3", "4", "5", "6", "7", "8", "9","10"]
    var buttonAddMore: UIButton = {
        let btn = UIButton()
        btn.setAttributedTitle(NSAttributedString(string: "adicionar mais", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15, weight: .semibold)]), for: .normal)
        btn.setTitleColor(.black, for: .normal)
        return btn
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        backgroundColor = .clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setupView() {
        myTableView.delegate = self
        myTableView.dataSource = self
        myTableView.register(TableCell.self, forCellReuseIdentifier: "nextTableCellId")
        myTableView.isScrollEnabled = false
        
        contentView.addSubview(myTableView)
        myTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            myTableView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            myTableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            myTableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            myTableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15)
        ])
    }
}

extension FaceTableViewCell: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "nextTableCellId", for: indexPath) as! TableCell
        cell.label.text = list[indexPath.row]
        cell.layoutIfNeeded()
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .cyan
        view.addSubview(buttonAddMore)
        
        buttonAddMore.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buttonAddMore.heightAnchor.constraint(equalToConstant: 40),
            buttonAddMore.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            buttonAddMore.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            buttonAddMore.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        buttonAddMore.addTarget(self, action: #selector(addItens), for: .touchUpInside)
        return view
    }
    
    @objc private func addItens() {
        let last = list.count + 1
        list.append("\(last)")
//        delegate?.added()
        myTableView.beginUpdates()
        self.myTableView.insertRows(at: [IndexPath(row: self.list.count - 1, section: 0)], with: .automatic)
        myTableView.endUpdates()
    }
}
