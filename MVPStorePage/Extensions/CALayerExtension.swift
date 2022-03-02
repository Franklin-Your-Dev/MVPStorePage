//
//  CALayerExtension.swift
//  MVPStorePage
//
//  Created by Franklin Gaspar on 23/02/22.
//

import UIKit

public extension CALayer {

  func applyShadow(
    color: UIColor = .black,
    alpha: Float = 0.0,
    x: CGFloat = 0,
    y: CGFloat = 0,
    blur: CGFloat = 0,
    spread: CGFloat = 0,
    radius: CGFloat = 0
  ) {
    shadowColor = color.cgColor
    shadowOpacity = alpha
    shadowOffset = CGSize(width: x, height: y)
    shadowRadius = radius

    if spread == 0 {
      shadowPath = nil
    } else {
      let dxSpread = -spread
      let rect = bounds.insetBy(dx: dxSpread, dy: dxSpread)
      shadowPath = UIBezierPath(rect: rect).cgPath
    }
  }
}
