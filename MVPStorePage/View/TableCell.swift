//
//  ViewCell.swift
//  MVPStorePage
//
//  Created by Franklin Gaspar on 23/02/22.
//

import UIKit

class TableCell: UITableViewCell {
  let img = UIImageView()

  lazy var imgHeightConstraint: NSLayoutConstraint = {
    img.heightAnchor.constraint(equalToConstant: 100)
  }()


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
    img.backgroundColor = .green
    contentView.addSubview(img)
    img.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      img.topAnchor.constraint(equalTo: contentView.topAnchor),
      img.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      img.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      imgHeightConstraint
    ])

    contentView.addSubview(label)
    label.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      label.topAnchor.constraint(equalTo: img.bottomAnchor, constant: 15),
      label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
      label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant:  -15)
    ])
  }

  func updateSizeImage(ratio: CGFloat, onCompletion completion: (() -> Void)? = nil) {
    imgHeightConstraint.constant = contentView.frame.size.width / ratio
    completion?()
  }
}


