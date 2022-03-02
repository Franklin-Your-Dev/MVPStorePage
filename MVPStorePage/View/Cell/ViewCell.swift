//
//  ViewCell.swift
//  MVPStorePage
//
//  Created by Franklin Gaspar on 23/02/22.
//

import UIKit

class ViewCell: UITableViewCell {

  var collapse: YDCollapseView?
  
  lazy var collapseHeightContraint: NSLayoutConstraint = {
    heightAnchor.constraint(equalToConstant: 47)
  }()

  public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)

    configureCollapse()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}


extension ViewCell {
  func configureCollapse() {
    collapse = YDCollapseView(viewVC: self.contentView)
    contentView.addSubview(collapse!)

    collapse!.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      collapse!.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 16),
      collapse!.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      collapse!.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      collapse!.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
    ])
  }
}
