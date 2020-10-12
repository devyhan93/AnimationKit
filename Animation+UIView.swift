//
//  Animation + UIView.swift
//  AnimationKit
//
//  Created by 요한 on 2020/10/12.
//

import UIKit

extension Animation where Origin: NSObject {
  public func spread(target: UIView) -> Void {
    UIView.animate(withDuration: 1.0, animations: {
      target.transform = CGAffineTransform(scaleX: 2, y: 2)
      target.alpha = 0
    })
  }
}
