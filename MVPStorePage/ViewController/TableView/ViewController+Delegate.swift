//
//  ViewController+Delegate.swift
//  MVPStorePage
//
//  Created by Franklin Gaspar on 23/02/22.
//

import UIKit

extension ViewController: UITableViewDataSource, UITableViewDelegate {

  func numberOfSections(in tableView: UITableView) -> Int {
    return 2
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if section == 0 {
      return content.count
    } else {
      return 1
    }
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if indexPath.section == 0 {
      let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ExpandableCell
      cell.backgroundColor = .blue
      cell.delegate = self
      cell.set(content[indexPath.row])
      return cell
    } else {
      let cell = tableView.dequeueReusableCell(withIdentifier: "firstTableCellId", for: indexPath) as! FaceTableViewCell
      cell.delegate = self
      return cell
    }
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    if indexPath.section == 0 {
      content[indexPath.row].expanded.toggle()
      tableView.reloadRows(at: [indexPath], with: .automatic)
    }
  }
}

extension ViewController: DynamicInsertDelegate {
  func reloadData() {
    tableView.beginUpdates()
    tableView.endUpdates()
  }

  func added(in table: UITableView, data: Int) {
    tableView.beginUpdates()
    table.insertRows(at: [IndexPath(row: data, section: 0)], with: .automatic)
    tableView.reloadData()
    tableView.endUpdates()
  }
}

extension ViewController: ExpandableDelegate {
  func didTapButton() {
    let alert = UIAlertController(title: "Mensagem", message: "Você clicou no botão", preferredStyle: .alert)
    let done = UIAlertAction(title: "Ok", style: .default)
    alert.addAction(done)
    present(alert, animated: true)
  }
}
