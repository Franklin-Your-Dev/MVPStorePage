//
//  YDCollapseView+Animation.swift
//  MVPStorePage
//
//  Created by Franklin Gaspar on 23/02/22.
//

import UIKit

// MARK: closeCollapse
extension YDCollapseView {
  func closeCollapse() {
    DispatchQueue.main.async { [weak self] in
      guard let self = self else { return }
      self.collapseHeightContraint.constant = 47
      self.onTapCallback?()
    }
  }
}


// MARK: openCollapse
extension YDCollapseView {
    func openCollapse() {
        self.collapseHeightContraint.constant = 292
        self.onTapCallback?()
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.viewOpen.layoutIfNeeded()
        }
    }
}

extension YDCollapseView {
  func animation() {
    UIView.animate(withDuration: 0.5, animations: {
      self.contentView.layoutIfNeeded()
    })
  }
}
