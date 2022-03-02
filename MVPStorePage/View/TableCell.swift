//
//  ViewCell.swift
//  MVPStorePage
//
//  Created by Franklin Gaspar on 23/02/22.
//

import UIKit

class TableCell: UITableViewCell {
  let label: UILabel = {
    let label = UILabel()
    label.textColor = UIColor.black
    label.sizeToFit()
    return label
  }()

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupView()
    backgroundColor = .red
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func setupView(){
    addSubview(label)
    label.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      label.topAnchor.constraint(equalTo: topAnchor, constant: 15),
      label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15)
    ])
  }
}
