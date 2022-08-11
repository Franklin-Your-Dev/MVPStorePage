//
//  ViewCell.swift
//  MVPStorePage
//
//  Created by Franklin Gaspar on 23/02/22.
//

import UIKit

class TableCell: UITableViewCell {
  lazy var imgHeightConstraint: NSLayoutConstraint = {
    img.heightAnchor.constraint(equalToConstant: 100)
  }()

  let container = UIView()
  let img = UIImageView()
  let label: UILabel = {
    let label = UILabel()
    label.textColor = UIColor.black
    label.sizeToFit()
    return label
  }()

  private var buttonLink: UIButton = {
    let btn = UIButton()
    btn.backgroundColor = .blue
    btn.setTitle("Click", for: .normal)
    return btn
  }()

  var callbackButton: (() -> Void)?

  var cellCollapse = false

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupView()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func setupView(){

    contentView.addSubview(container)
    container.backgroundColor = .white

    container.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      container.topAnchor.constraint(equalTo: contentView.topAnchor),
      container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
    ])

    container.addSubview(img)
    img.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      img.topAnchor.constraint(equalTo: container.topAnchor),
      img.leadingAnchor.constraint(equalTo: container.leadingAnchor),
      img.trailingAnchor.constraint(equalTo: container.trailingAnchor),
      imgHeightConstraint
    ])

    container.addSubview(label)
    label.backgroundColor = .green
    label.numberOfLines = 1
    
    label.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      label.topAnchor.constraint(equalTo: img.bottomAnchor, constant: 15),
      label.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 15),
      label.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -15)
    ])


    container.addSubview(buttonLink)

    buttonLink.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      buttonLink.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 5),
      buttonLink.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -15),
      buttonLink.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant:  -15)
    ])

    buttonLink.addTarget(self, action: #selector(btnTapped), for: .touchUpInside)
  }

  @objc private func btnTapped() {

    if cellCollapse {
      label.numberOfLines = 1
      cellCollapse.toggle()
    } else {
      label.numberOfLines = 0
      cellCollapse.toggle()
    }

    callbackButton?()
  }

  func updateSizeImage(ratio: CGFloat, onCompletion completion: (() -> Void)? = nil) {
    imgHeightConstraint.constant = contentView.frame.size.width / ratio
    completion?()
  }
}


