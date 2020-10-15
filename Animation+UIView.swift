//
//  Animation + UIView.swift
//  AnimationKit
//
//  Created by 요한 on 2020/10/12.
//

import UIKit

extension Animation where Origin: NSObject {
  public func fadeIn(target view: UIView, duration: Double? = nil, additional: (()->Void)? = nil, completion: ((Bool)->Void)? = nil) -> Void {
    view.alpha = 0
    UIView.animate(withDuration: duration ?? 1.0, animations: {
      view.alpha = 1
      additional?()
    }, completion: completion)
  }
  
  public func fadeOut(target view: UIView, duration: Double? = nil, additional: (()->Void)? = nil, completion: ((Bool)->Void)? = nil) -> Void {
    view.alpha = 1
    UIView.animate(withDuration: duration ?? 1.0, animations: {
      view.alpha = 0
      additional?()
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
