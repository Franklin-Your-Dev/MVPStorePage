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
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ExpandableCell
            cell.backgroundColor = .blue
            cell.set(content[indexPath.row])
            return cell
            //      cell.onTapCallback = {
            //
            //        let lastScrollOffset = tableView.contentOffset
            //
            //        tableView.beginUpdates()
            //        tableView.reloadRows(at: [indexPath], with:.automatic)
            //        tableView.endUpdates()
            //
            //        tableView.layer.removeAllAnimations()
            //        tableView.setContentOffset(lastScrollOffset, animated: false)
            //
            //      }
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "firstTableCellId", for: indexPath) as! FaceTableViewCell
            cell.callback = {
                tableView.beginUpdates()
                tableView.reloadRows(at: [indexPath], with:.automatic)
                tableView.endUpdates()
                self.loadViewIfNeeded()
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            tableView.deselectRow(at: indexPath, animated: true)
            content[indexPath.row].expanded.toggle()
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
}

