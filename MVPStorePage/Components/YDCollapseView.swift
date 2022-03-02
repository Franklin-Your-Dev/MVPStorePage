//
//  CollapseView.swift
//  MVPStorePage
//
//  Created by Franklin Gaspar on 23/02/22.
//

import UIKit

class YDCollapseView: UITableViewCell {

  // MARK: Variable
  var collapseOpened = false
  public var onTapCallback: (() -> Void)?

  // MARK: Views
  let viewClose = UIView()
  let viewOpen = UIView()

  lazy var collapseHeightContraint: NSLayoutConstraint = {
    viewOpen.heightAnchor.constraint(equalToConstant: 47)
  }()

  // MARK: Init
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    initViews()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: ConfigUI
extension YDCollapseView {
  func initViews() {
    configureYDCollapseView()
    configureViewOpen()
    configureViewClose()

  }
}

// MARK: YDCollapse
extension YDCollapseView {
  func configureYDCollapseView() {
    backgroundColor = .clear
    translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      collapseHeightContraint
    ])
  }
}

extension YDCollapseView {
  func configureViewOpen() {
    contentView.addSubview(viewOpen)
    viewOpen.layer.cornerRadius = 16
    viewOpen.layer.applyShadow(color: .systemGray, alpha: 0.1, x: 0, y: 5, blur: 5, spread: -5, radius: 16)
    viewOpen.backgroundColor = .white
    viewOpen.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      viewOpen.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
      viewOpen.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      viewOpen.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      viewOpen.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -4)
    ])
  }
}

// MARK: viewMinimized
extension YDCollapseView {
  func configureViewClose() {
    contentView.addSubview(viewClose)
    viewClose.layer.cornerRadius = 8
    viewClose.layer.applyShadow(
      color: .systemGray,
      alpha: 0.2,
      x: 0,
      y: 1,
      blur: 8,
      spread: -0.05,
      radius: 8)
    viewClose.backgroundColor = .white

    viewClose.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      viewClose.topAnchor.constraint(equalTo: viewOpen.topAnchor),
      viewClose.trailingAnchor.constraint(equalTo: viewOpen.trailingAnchor),
      viewClose.leadingAnchor.constraint(equalTo: viewOpen.leadingAnchor),
      viewClose.heightAnchor.constraint(equalToConstant: 47)
    ])

    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapCollapse))
    viewClose.addGestureRecognizer(tapGesture)
  }

  @objc private func tapCollapse() {
    if collapseOpened {
      closeCollapse()
      collapseOpened = false
    } else {
      openCollapse()
      collapseOpened = true
    }
  }
}

