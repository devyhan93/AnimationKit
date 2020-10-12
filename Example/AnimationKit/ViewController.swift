//
//  ViewController.swift
//  AnimationKit
//
//  Created by devyhan93@gmail.com on 10/12/2020.
//  Copyright (c) 2020 devyhan93@gmail.com. All rights reserved.
//

import UIKit
import AnimationKit

class ViewController: UIViewController {
  
  @IBOutlet var someView: UIView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setUI()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  fileprivate func setUI() {
    ani.spread(target: someView)
  }
}

