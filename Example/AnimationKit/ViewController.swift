//
//  ViewController.swift
//  AnimationKit
//
//  Created by devyhan93@gmail.com on 10/12/2020.
//  Copyright (c) 2020 devyhan93@gmail.com. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  enum Section {
    case main
  }
  
  var outlineCollectionView: UICollectionView! = nil
  var dataSource: UICollectionViewDiffableDataSource<Section, OutlineItem>! = nil
  
  class OutlineItem: Hashable {
    let title: String
    let subitems: [OutlineItem]
    let outlineViewController: UIViewController.Type?
    
    init(title: String,
         viewController: UIViewController.Type? = nil,
         subitems: [OutlineItem] = []) {
      self.title = title
      self.subitems = subitems
      self.outlineViewController = viewController
    }
    func hash(into hasher: inout Hasher) {
      hasher.combine(identifier)
    }
    static func == (lhs: OutlineItem, rhs: OutlineItem) -> Bool {
      return lhs.identifier == rhs.identifier
    }
    private let identifier = UUID()
  }
  
  fileprivate lazy var menuItems: [OutlineItem] = {
    return [
      OutlineItem(title: "UIView", subitems: [
        OutlineItem(title: "Fade", subitems: [
          OutlineItem(title: "FadeIn", viewController: FadeInViewController.self),
          OutlineItem(title: "FadeOut", viewController: FadeOutViewController.self)
        ]),
        OutlineItem(title: "Shake", subitems: [
          OutlineItem(title: "Shake", viewController: ViewController.self)
        ])
      ])
    ]
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureUI()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  fileprivate func configureUI() {
    self.view.backgroundColor = .systemGroupedBackground
    self.navigationItem.title = "AnimationKit"
    
    configureCollectionView()
    configureDataSource()
    configureCollectionViewConstant()
  }
}

extension ViewController {
  fileprivate func configureCollectionView() {
    let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: generateLayout())
    self.view.addSubview(collectionView)
    self.outlineCollectionView = collectionView
    collectionView.delegate = self
    collectionView.backgroundColor = .magenta
  }
  
  fileprivate func configureDataSource() {
    
    let containerCellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, OutlineItem> { (cell, indexPath, menuItem) in
      // Populate the cell with our item description.
      var contentConfiguration = cell.defaultContentConfiguration()
      contentConfiguration.text = menuItem.title
      contentConfiguration.textProperties.font = .preferredFont(forTextStyle: .headline)
      cell.contentConfiguration = contentConfiguration
      
      let disclosureOptions = UICellAccessory.OutlineDisclosureOptions(style: .header)
      cell.accessories = [.outlineDisclosure(options:disclosureOptions)]
      cell.backgroundConfiguration = UIBackgroundConfiguration.clear()
    }
    
    let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, OutlineItem> { cell, indexPath, menuItem in
      // Populate the cell with our item description.
      var contentConfiguration = cell.defaultContentConfiguration()
      contentConfiguration.text = menuItem.title
      cell.contentConfiguration = contentConfiguration
      cell.backgroundConfiguration = UIBackgroundConfiguration.clear()
    }
    
    dataSource = UICollectionViewDiffableDataSource<Section, OutlineItem>(collectionView: outlineCollectionView) {
      (collectionView: UICollectionView, indexPath: IndexPath, item: OutlineItem) -> UICollectionViewCell? in
      // Return the cell.
      if item.subitems.isEmpty {
        return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
      } else {
        return collectionView.dequeueConfiguredReusableCell(using: containerCellRegistration, for: indexPath, item: item)
      }
    }
    
    // load our initial data
    let snapshot = initialSnapshot()
    self.dataSource.apply(snapshot, to: .main, animatingDifferences: false)
  }
  
  fileprivate func configureCollectionViewConstant() {
    outlineCollectionView.translatesAutoresizingMaskIntoConstraints = false
    
    let margins = view.layoutMarginsGuide
    NSLayoutConstraint.activate([
      outlineCollectionView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
      outlineCollectionView.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
    ])
    
    let guide = view.safeAreaLayoutGuide
    NSLayoutConstraint.activate([
      outlineCollectionView.topAnchor.constraintEqualToSystemSpacingBelow(guide.topAnchor, multiplier: 1.0),
      guide.bottomAnchor.constraintEqualToSystemSpacingBelow(outlineCollectionView.bottomAnchor, multiplier: 1.0)
    ])
  }
  
  fileprivate func generateLayout() -> UICollectionViewLayout {
    let listConfiguration = UICollectionLayoutListConfiguration(appearance: .sidebar)
    let layout = UICollectionViewCompositionalLayout.list(using: listConfiguration)
    return layout
  }
  
  fileprivate func initialSnapshot() -> NSDiffableDataSourceSectionSnapshot<OutlineItem> {
    var snapshot = NSDiffableDataSourceSectionSnapshot<OutlineItem>()
    
    func addItems(_ menuItems: [OutlineItem], to parent: OutlineItem?) {
      snapshot.append(menuItems, to: parent)
      for menuItem in menuItems where !menuItem.subitems.isEmpty {
        addItems(menuItem.subitems, to: menuItem)
      }
    }
    
    addItems(menuItems, to: nil)
    return snapshot
  }
}

extension ViewController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    guard let menuItem = self.dataSource.itemIdentifier(for: indexPath) else { return }
    
    collectionView.deselectItem(at: indexPath, animated: true)
    
    if let viewController = menuItem.outlineViewController {
      navigationController?.pushViewController(viewController.init(), animated: true)
    }
  }
}

