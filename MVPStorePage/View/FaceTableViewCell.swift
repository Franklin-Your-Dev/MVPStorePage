//
//  faceTableViewCell.swift
//  MVPStorePage
//
//  Created by Franklin Gaspar on 27/02/22.
//

import UIKit

class FaceTableViewCell: UITableViewCell {

  var myTableView = InnerTableView()
  var list = ["1","2", "3", "4", "5", "6", "7", "8", "9","10"]

  var callback: (() -> Void)?

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
    myTableView.register(TableFooter.self, forHeaderFooterViewReuseIdentifier: "footer")
    myTableView.isScrollEnabled = false

    addSubview(myTableView)
    myTableView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      myTableView.topAnchor.constraint(equalTo: topAnchor, constant: 15),
      myTableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
      myTableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
      myTableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15)
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

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "nextTableCellId", for: indexPath) as! TableCell
    cell.label.text = list[indexPath.row]
    return cell
  }

  func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: "footer") as! TableFooter
    let tap = UITapGestureRecognizer(target: self, action: #selector(addItens))
    cell.addGestureRecognizer(tap)

    return cell
  }

  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return 50
  }

  @objc private func addItens() {
    let last = list.count + 1
    list.append("\(last)")
    myTableView.reloadData()
    callback?()
  }
}


class TableFooter: UITableViewHeaderFooterView {
  let label = UILabel()

  override init(reuseIdentifier: String?) {
    super.init(reuseIdentifier: reuseIdentifier)

    label.backgroundColor = .cyan
    label.textColor = .black
    label.textAlignment = .center
    label.text = "adicionar mais"

    addSubview(label)
    label.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      label.topAnchor.constraint(equalTo: topAnchor),
      label.leadingAnchor.constraint(equalTo: leadingAnchor),
      label.trailingAnchor.constraint(equalTo: trailingAnchor),
      label.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
