//
//  faceTableViewCell.swift
//  MVPStorePage
//
//  Created by Franklin Gaspar on 27/02/22.
//

import UIKit

protocol DynamicInsertDelegate {
  func added(in table: UITableView, data: Int)
  func reloadData()
}

class FaceTableViewCell: UITableViewCell {
  var myTableView = InnerTableView()
  var delegate: DynamicInsertDelegate?
  var list = [
    ModelItem(img: "https://www.industrialempathy.com/img/remote/ZiClJf-1920w.jpg", label: "imagem 1"),
    ModelItem(img: "https://www.w3schools.com/w3css/img_lights.jpg", label: "imagem 2"),
    ModelItem(img: "https://images.unsplash.com/photo-1509266272358-7701da638078?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=986&q=80", label: "imagem 3"),
    ModelItem(img: "https://images.unsplash.com/photo-1524995997946-a1c2e315a42f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2340&q=80", label: "imagem 4"),
    ModelItem(img: "https://www.w3schools.com/w3css/img_lights.jpg", label: "imagem 5")
  ]
  
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
      myTableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      myTableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
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

    let item = list[indexPath.row]

    cell.label.text = item.label
    
    cell.img.downloadedFrom(urlString: item.img) {
      guard let width = cell.img.image?.size.width,
            let height = cell.img.image?.size.height
      else {
        return
      }

      let ratio = width / height

      cell.updateSizeImage(ratio: ratio) {
        tableView.beginUpdates()
        cell.layoutIfNeeded()
        tableView.endUpdates()
        self.delegate?.reloadData()
      }
    }

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
    myTableView.beginUpdates()
    let last = ModelItem(img: "https://helpx.adobe.com/content/dam/help/en/stock/how-to/visual-reverse-image-search/jcr_content/main-pars/image/visual-reverse-image-search-v2_intro.jpg.img.jpg", label: "Imagem 6")
    list.append(last)
    delegate?.added(in: myTableView, data: list.count - 1)
    myTableView.endUpdates()
  }
}

extension UIImageView {
  func downloadedFrom(
    urlString: String?,
    contentMode mode: UIView.ContentMode = .scaleAspectFill,
    onCompletion completion: (() -> Void)? = nil) {
    guard let urlString = urlString else { return }
    guard let url = URL(string: urlString) else { return }
    contentMode = mode

    URLSession.shared.dataTask(with: url) { (data, response, error) in
      guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
            let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
            let data = data, error == nil,
            let image = UIImage(data: data)
      else { return }
      DispatchQueue.main.async() { () -> Void in
        self.image = image
        completion?()
      }
    }.resume()
  }
}
