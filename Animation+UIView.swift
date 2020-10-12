//
//  Animation + UIView.swift
//  AnimationKit
//
//  Created by 요한 on 2020/10/12.
//

import UIKit

extension Animation where Origin: NSObject {
  public func fadeIn(target: UIView, completion: ((Bool)->Void)? = nil) -> Void {
    target.alpha = 0
    UIView.animate(withDuration: 1.0, animations: {
      target.alpha = 1
    }, completion: completion)
  }
  
  public func fadeOut(target: UIView, completion: ((Bool)->Void)? = nil) -> Void {
    target.alpha = 1
    UIView.animate(withDuration: 1.0, animations: {
      target.alpha = 0
    }, completion: completion)
  }
  
  public func shake(target view: UIView) -> Void {
    UIView.animateKeyframes(
      withDuration: 0.2,
      delay: 2,
      options: [],
      animations: {
        UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.25) {
          view.center.x += 4
        }
        UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.25) {
          view.center.x -= 8
        }
        UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.25) {
          view.center.x += 4
        }
        UIView.addKeyframe(withRelativeStartTime: 0.75, relativeDuration: 0.25) {
          view.center.x -= 8
        }
      }, completion: nil
    )
  }
}
