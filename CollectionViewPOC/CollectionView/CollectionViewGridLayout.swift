//
//  FlexibleCollectionViewLayout.swift
//  FlexibleCollectionView-iOS
//
//  Created by Carlos Duclos on 10/13/18.
//  Copyright © 2018 FlexibleCollectionView. All rights reserved.
//

import Foundation
import UIKit

class CollectionViewGridLayoutInvalidationContext: UICollectionViewLayoutInvalidationContext {
    
    var invalidatedBecauseOfBoundsChange: Bool = false
}

// MARK: CollectionViewGridLayoutDelegate

@objc protocol CollectionViewGridLayoutDelegate: class {
    
    @objc func collectionView(_ collectionView: UICollectionView,
                              gridLayout: UICollectionViewLayout,
                              estimatedHeightForItemAt indexPath: IndexPath) -> CGFloat
}

// MARK: CollectionViewGridLayout

class CollectionViewGridLayout: UICollectionViewLayout {

    // MARK: Delegate

    weak var delegate: CollectionViewGridLayoutDelegate?

    // MARK: Variables

    @IBInspectable var estimatedRowHeight: CGFloat = 500

    private var layoutAttributesForItems: [CollectionViewGridLayoutAttribute] = []
    private var contentHeight: CGFloat = 0
    private var contentWidth: CGFloat {
        guard let collectionView = collectionView else {
            return 0
        }

        let insets = collectionView.contentInset
        return collectionView.bounds.width - (insets.left + insets.right)
    }
    
    private var viewModels: [ItemViewModel] = []

    private var numberOfColumns: Int

    private var cellWidth: CGFloat {
        guard let collectionView = collectionView else {
            return 0
        }

        return floor((collectionView.frame.width - CGFloat(numberOfColumns)))
    }

    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }

    override class var invalidationContextClass: AnyClass {
        return CollectionViewGridLayoutInvalidationContext.self
    }

    // MARK: Methods
    
    init(columns: Int, viewModels: [ItemViewModel]) {
        self.numberOfColumns = columns
        self.viewModels = viewModels
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func invalidateLayout(with context: UICollectionViewLayoutInvalidationContext) {
        let invalidationContext = context as! CollectionViewGridLayoutInvalidationContext

        super.invalidateLayout(with: invalidationContext)

        if invalidationContext.invalidatedBecauseOfBoundsChange || invalidationContext.invalidateEverything {
            layoutAttributesForItems = []
        }
        
        print("")
        print("-------------------------------------------------------------------------------")
        print("invalidateLayout:withContext", invalidationContext.invalidatedBecauseOfBoundsChange, invalidationContext.invalidateEverything)
        print("-------------------------------------------------------------------------------")
    }

    override func prepare() {
        guard layoutAttributesForItems.isEmpty else {
            print("")
            print("-------------------------------------------------------------------------------")
            print("Avoiding to recalculate frames")
            print("-------------------------------------------------------------------------------")
            return
        }

        print("")
        print("-------------------------------------------------------------------------------")
        print("initialLayout")
        print("-------------------------------------------------------------------------------")
        initalLayout()
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        print("")
        print("-------------------------------------------------------------------------------")
        print("layoutAttributesForElements:inRect", rect)
        print("-------------------------------------------------------------------------------")
        
        var visibleLayoutAttributes: [UICollectionViewLayoutAttributes] = []

        for attributes in layoutAttributesForItems {
            if attributes.frame.intersects(rect) {
                visibleLayoutAttributes.append(attributes)
            }
        }
        return visibleLayoutAttributes
    }

    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        var flag = true
        if let collectionView = collectionView {
            flag = newBounds.size != collectionView.frame.size
        }

        print("")
        print("-------------------------------------------------------------------------------")
        print("shouldInvalidateLayout:forBoundsChange", flag)
        print("-------------------------------------------------------------------------------")
        
        return flag
    }
    
    override func shouldInvalidateLayout(
        forPreferredLayoutAttributes preferredAttributes: UICollectionViewLayoutAttributes,
        withOriginalAttributes originalAttributes: UICollectionViewLayoutAttributes
    ) -> Bool {
        print("")
        print("-------------------------------------------------------------------------------")
        print("shouldInvalidateLayout:forPreferredLayoutAttributes:withOriginalAttributes")
        print("preferred", preferredAttributes.frame)
        print("original", originalAttributes.frame)
        
        var flag = true
        if preferredAttributes.frame.size.height == originalAttributes.frame.size.height && originalAttributes.frame.size.width == cellWidth {
            flag = false
        }

        print("flag", flag)
        print("-------------------------------------------------------------------------------")
        return flag
    }

    override func invalidationContext(forBoundsChange newBounds: CGRect) -> UICollectionViewLayoutInvalidationContext {
        print("")
        print("-------------------------------------------------------------------------------")
        print("invalidationContext:forBoundsChange", newBounds)
        print("-------------------------------------------------------------------------------")
        let context = super.invalidationContext(forBoundsChange: newBounds) as! CollectionViewGridLayoutInvalidationContext
        context.invalidatedBecauseOfBoundsChange = true
        return context
    }

    override func invalidationContext(
        forPreferredLayoutAttributes preferredAttributes: UICollectionViewLayoutAttributes,
        withOriginalAttributes originalAttributes: UICollectionViewLayoutAttributes
    ) -> UICollectionViewLayoutInvalidationContext {
        print("")
        print("-------------------------------------------------------------------------------")
        print("invalidationContext:forPreferredLayoutAttributes:withOriginalAttributes")
        print("preferred", preferredAttributes.frame)
        print("original", originalAttributes.frame)
        print("-------------------------------------------------------------------------------")
        
        let context = super.invalidationContext(forPreferredLayoutAttributes: preferredAttributes,
                                                withOriginalAttributes: originalAttributes) as! CollectionViewGridLayoutInvalidationContext

        let contentHeightAdjustment: CGFloat = preferredAttributes.frame.size.height - originalAttributes.frame.size.height

        let columnWidth = contentWidth / CGFloat(numberOfColumns)
        let attributes = layoutAttributesForItems[originalAttributes.indexPath.row]
        attributes.frame.size.height += contentHeightAdjustment
        attributes.frame.size.width = columnWidth

        context.invalidateItems(at: [attributes.indexPath])

        layoutAttributesForItems[originalAttributes.indexPath.row] = attributes

        for (index, layoutAttributesForItem) in layoutAttributesForItems.enumerated() {
            if index <= originalAttributes.indexPath.row {
                continue
            }

            let currentColumn = layoutAttributesForItem.column

            if currentColumn == attributes.column {
                layoutAttributesForItem.frame.origin.y += contentHeightAdjustment
                context.invalidateItems(at: [layoutAttributesForItem.indexPath])
            }
        }

        let count = layoutAttributesForItems.count - 1

        if count < numberOfColumns {
            let attributesSlice = layoutAttributesForItems[count...layoutAttributesForItems.count - 1]
            let attributes = Array(attributesSlice)
            collectionViewHeight(from: attributes, context: context)
        } else {
            let attributesSlice = layoutAttributesForItems[(count - numberOfColumns + 1)...count]
            let attributes = Array(attributesSlice)
            collectionViewHeight(from: attributes, context: context)
        }

        return context
    }

    private func collectionViewHeight(from lastRowCellAttributes: [UICollectionViewLayoutAttributes],
                                      context: CollectionViewGridLayoutInvalidationContext) {
        let maxColumn = lastRowCellAttributes.max { (attribute1, attribute2) -> Bool in
            attribute1.frame.maxY < attribute2.frame.maxY
        }

        let diff = contentHeight - maxColumn!.frame.maxY

        context.contentSizeAdjustment = CGSize(width: 0, height: diff)
        contentHeight = maxColumn!.frame.maxY
    }

    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        print("")
        print("-------------------------------------------------------------------------------")
        print("layoutAttributesForItem", indexPath)
        print("-------------------------------------------------------------------------------")
        return layoutAttributesForItems[indexPath.item]
    }

    func initalLayout() {
        layoutAttributesForItems = []

        guard let collectionView = collectionView,
            let dataSource = collectionView.dataSource else {
                return
        }

        contentHeight = collectionView.contentInset.top

        let numberOfSections = dataSource.numberOfSections?(in: collectionView) ?? 1
        let columnWidth = contentWidth / CGFloat(numberOfColumns)

        var column = 0
        var yOffset = [CGFloat](repeating: 0, count: numberOfColumns)
        var xOffset = [CGFloat]()
        for column in 0 ..< numberOfColumns {
            xOffset.append(CGFloat(column) * columnWidth)
        }

        for section in (0..<numberOfSections) {

            for row in (0..<dataSource.collectionView(collectionView, numberOfItemsInSection: section)) {
                let indexPath = IndexPath(row: row, section: section)

                let estimatedHeightForItem: CGFloat
                if let height = delegate?.collectionView(collectionView, gridLayout: self, estimatedHeightForItemAt: indexPath) {
                    estimatedHeightForItem = height
                } else {
                    estimatedHeightForItem = estimatedRowHeight
                }

                let frame = CGRect(x: xOffset[column], y: yOffset[column], width: columnWidth, height: estimatedHeightForItem)
                let insetFrame = frame.insetBy(dx: collectionView.contentInset.left, dy: collectionView.contentInset.right)

                let attributes = CollectionViewGridLayoutAttribute(forCellWith: indexPath)
                attributes.frame = insetFrame
                attributes.column = column
                layoutAttributesForItems.append(attributes)

                contentHeight = max(contentHeight, frame.maxY)
                yOffset[column] = yOffset[column] + estimatedHeightForItem

                column = column < (numberOfColumns - 1) ? (column + 1) : 0
            }
        }

        contentHeight += collectionView.contentInset.bottom
    }
}
