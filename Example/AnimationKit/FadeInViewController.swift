//
//  SpreadViewController.swift
//  AnimationKit_Example
//
//  Created by 요한 on 2020/10/13.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import AnimationKit
import SnapKit

class FadeInViewController: UIViewController {
  
  fileprivate let motionView: UIView = {
    let view = UIView()
    view.backgroundColor = .magenta
    
    return view
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureUI()
  }
  
  fileprivate func configureUI() {
    self.view.backgroundColor = .systemGroupedBackground
    self.navigationItem.title = "FadeIn"
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Reload", style: .plain, target: self, action: #selector(configureAction))
    
    configureConstant()
  }
}

extension FadeInViewController {
  fileprivate func configureConstant() {
    [motionView].forEach {
      self.view.addSubview($0)
    }
    
    motionView.snp.makeConstraints {
      $0.centerX.centerY.equalToSuperview()
      $0.height.width.equalTo(100)
    }
  }
  
  fileprivate func configureAnimation() {
    ani.fadeIn(target: motionView) { _ in
      self.motionView.transform = .identity
    }
  }
  
  @objc fileprivate func configureAction() {
    configureAnimation()
  }
}
