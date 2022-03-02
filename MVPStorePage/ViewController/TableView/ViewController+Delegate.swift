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
      return 3
    } else {
      return 1
    }
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    if indexPath.section == 0 {
      let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! YDCollapseView
      cell.onTapCallback = {

        let lastScrollOffset = tableView.contentOffset

        tableView.beginUpdates()
        tableView.reloadRows(at: [indexPath], with:.automatic)
        tableView.endUpdates()

        tableView.layer.removeAllAnimations()
        tableView.setContentOffset(lastScrollOffset, animated: false)

      }
      return cell
    } else {
      let cell = tableView.dequeueReusableCell(withIdentifier: "firstTableCellId", for: indexPath) as! FaceTableViewCell
      cell.callback = {



//        let lastScrollOffset = tableView.contentOffset
//
        tableView.beginUpdates()
        tableView.reloadRows(at: [indexPath], with:.automatic)

        tableView.endUpdates()
//
//        tableView.layer.removeAllAnimations()
//        tableView.setContentOffset(lastScrollOffset, animated: false)

        self.loadViewIfNeeded()
      }
      return cell
    }
  }
}

