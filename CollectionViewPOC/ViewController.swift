//
//  ViewController.swift
//  CollectionViewPOC
//
//  Created by Carlos Duclos on 8/06/21.
//

import UIKit

//let globalItems: [ItemViewModel] = [
//    ItemViewModel(title: "Article 1",
//                  description: "1. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
//                  color: .red),
//    ItemViewModel(title: "Article 2",
//                  description: "2. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
//                  color: .yellow),
//    ItemViewModel(title: "Article 3",
//                  description: "3. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
//                  color: .green),
//    ItemViewModel(title: "Article 4",
//                  description: "4. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
//                  color: .orange),
//    ItemViewModel(title: "Article 5",
//                  description: "5. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
//                  color: .gray),
//    ItemViewModel(title: "Article 6",
//                  description: "6. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
//                  color: .brown),
//    ItemViewModel(title: "Article 7",
//                  description: "7. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
//                  color: .cyan),
//    ItemViewModel(title: "Article 8",
//                  description: "8. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
//                  color: .magenta),
//    ItemViewModel(title: "Article 9",
//                  description: "9. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
//                  color: .tertiarySystemFill),
//    ItemViewModel(title: "Article 10",
//                  description: "10. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
//                  color: .separator),
//    ItemViewModel(title: "Article 11",
//                  description: "11. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
//                  color: .blue)
//]

final class ViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var collectionView: UICollectionView!

    fileprivate var isTargetContentOffsetAdjusted: Bool = false
    fileprivate var indexPathForViewSizeTransition: IndexPath?
    
    var gridLayout: CollectionViewGridLayout {
        return (collectionView.collectionViewLayout as! CollectionViewGridLayout)
    }
    
    private var items: [ItemViewModel] = []
    
    // MARK: - Properties
    
    lazy var doneButton: UIBarButtonItem = {
        return UIBarButtonItem(title: "Go", style: .done, target: self, action: #selector(goPressed))
    }()
    
    lazy var refreshControl: UIRefreshControl = {
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 13),
            .foregroundColor: UIColor.darkGray,
        ]
        var refreshControl = UIRefreshControl()
        refreshControl.transform = CGAffineTransform(scaleX: 0.75, y: 0.75);
        refreshControl.attributedTitle = NSAttributedString(string: "Refreshing...", attributes: attributes)
        refreshControl.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
        return refreshControl
    }()
    
    // MARK: - Functions
    
    override func viewDidLoad() {
        generateViewModels()
        setupUI()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        // To adjust the scroll view we need to get first recipe that is being displayed.
        indexPathForViewSizeTransition = collectionView.indexPathForItem(at: CGPoint(x: 0, y: collectionView.contentOffset.y))
        
        super.viewWillTransition(to: size, with: coordinator)
        
        self.isTargetContentOffsetAdjusted = false
        
        coordinator.animate(alongsideTransition: { (_) in
            // The target offset isn't called when coming in and out of split view on iPad, so we manually do it here.
            guard self.isTargetContentOffsetAdjusted == false else {
                return
            }
            
            guard let indexPathForViewSizeTransition = self.indexPathForViewSizeTransition,
                let layoutAttributes = self.collectionView.layoutAttributesForItem(at: indexPathForViewSizeTransition) else {
                    return
            }
            
            self.collectionView.contentOffset = CGPoint(x: 0, y: layoutAttributes.frame.origin.y)
            
        }, completion: { (_) in
            self.isTargetContentOffsetAdjusted = false
            self.indexPathForViewSizeTransition = nil
            let context = CollectionViewGridLayoutInvalidationContext()
            context.invalidatedBecauseOfBoundsChange = true
            self.collectionView.collectionViewLayout.invalidateLayout(with: context)
        })
    }
    
    private func setupUI() {
        navigationItem.rightBarButtonItem = doneButton
        
        collectionView.refreshControl = refreshControl
        collectionView.collectionViewLayout = CollectionViewGridLayout(columns: 2, viewModels: items)
        gridLayout.delegate = self
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    @objc private func goPressed() {
        items[0].toggle()
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    @objc func didPullToRefresh() {
        collectionView.collectionViewLayout.invalidateLayout()
        collectionView.reloadData()
        refreshControl.endRefreshing()
    }
    
    func generateViewModels() {
        let itemsCount = 500
        let charactersCount = 200
        for i in 0..<itemsCount {
            let item = ItemViewModel(title: "Article \(i)", description: String.random(length: charactersCount), color: UIColor.random)
            items.append(item)
        }
    }
}

/// This extension contains the delegate methods to make the UICollectionView work
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let viewModel = items[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "labelCell",
                                                      for: indexPath) as! LabelCell
        cell.configure(label: viewModel.displayedText, color: viewModel.color)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewModel = items[indexPath.row]
        viewModel.toggle()
        gridLayout.invalidateLayout()
        collectionView.reloadItems(at: [indexPath])
    }
    
    @objc func collectionView(_ collectionView: UICollectionView,
                              targetContentOffsetForProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
        guard let indexPathForViewSizeTransition = indexPathForViewSizeTransition,
            let layoutAttributes = collectionView.layoutAttributesForItem(at: indexPathForViewSizeTransition) else {
                return proposedContentOffset
        }
        
        // We have adjusted the target offset so don't do it else where.
        isTargetContentOffsetAdjusted = true
        
        return CGPoint(x: 0, y: layoutAttributes.frame.origin.y)
    }
}

extension ViewController: CollectionViewGridLayoutDelegate {
    
    func heightForIndexPath(_ collectionView: UICollectionView, indexPath: IndexPath, width: CGFloat) -> CGFloat {
        let viewModel = items[indexPath.row]
        return viewModel.calculateHeight(for: width)
    }
}

extension String {

    static func random(length: Int) -> String {
        let base = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var randomString: String = ""

        for _ in 0..<length {
            let randomValue = arc4random_uniform(UInt32(base.count))
            randomString += "\(base[base.index(base.startIndex, offsetBy: Int(randomValue))])"
        }
        return randomString
    }
    
    func heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect,
                                            options: [.usesLineFragmentOrigin, .usesFontLeading],
                                            attributes: [NSAttributedString.Key.font: font],
                                            context: nil)
        return boundingBox.height
    }
}

extension UIColor {
    
    static var random: UIColor {
        return UIColor(red: .random(in: 0...1),
                       green: .random(in: 0...1),
                       blue: .random(in: 0...1),
                       alpha: 1.0)
    }
}
