//
//  ExpandableCell.swift
//  MVPStorePage
//
//  Created by Leonardo Modro on 02/03/22.
//

import UIKit

protocol ExpandableDelegate {
  func didTapButton()
}

struct ExpandableContent {
  var title: String
  var subtitle: String
  var expanded: Bool = false
  
  static func generate() -> [ExpandableContent] {
    return [
      ExpandableContent(title: "Title 1", subtitle: "This is the expandable subtitle 1"),
      ExpandableContent(title: "Title 2", subtitle: "This is the expandable subtitle 2"),
      ExpandableContent(title: "Title 3", subtitle: "This is the expandable subtitle 3")
    ]
  }
}

class ExpandableCell: UITableViewCell {
  
  var delegate: ExpandableDelegate?
  private var titleLabel: UILabel = {
    let lbl = UILabel()
    return lbl
  }()
  private var buttonLink: UIButton = {
    let btn = UIButton()
    btn.setTitle("Click", for: .normal)
    return btn
  }()
  private var subtitleLabel: UILabel = {
    let lbl = UILabel()
    lbl.textColor = .white.withAlphaComponent(0.7)
    lbl.numberOfLines = 0
    lbl.lineBreakMode = .byWordWrapping
    return lbl
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  //MARK: - Setup Layout
  private func setupLayout() {
    [titleLabel, buttonLink, subtitleLabel].forEach({ contentView.addSubview($0) })
    
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
      titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
    ])
    
    buttonLink.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      buttonLink.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -5),
      buttonLink.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15)
    ])
    
    subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
      subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
      subtitleLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
      subtitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15)
    ])
    
    buttonLink.addTarget(self, action: #selector(btnTapped), for: .touchUpInside)
  }
  
  @objc private func btnTapped() {
    delegate?.didTapButton()
  }
  
  //MARK: - Set data to the cell
  public func set(_ data: ExpandableContent) {
    titleLabel.text = data.title
    
    subtitleLabel.text = data.expanded ? data.subtitle : ""
  }
  
}
