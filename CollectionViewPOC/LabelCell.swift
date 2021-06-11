//
//  LabelCell.swift
//  CollectionViewPOC
//
//  Created by Carlos Duclos on 8/06/21.
//

import Foundation
import UIKit
import PinLayout

class LabelCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    func configure(label: String, color: UIColor) {
        titleLabel.text = label
        contentView.backgroundColor = color
    }
    
//    override func layoutSubviews() {
//        contentView.pin.all(pin.safeArea)
//        titleLabel.pin.all(16)
//    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        setNeedsLayout()
        layoutIfNeeded()

        let preferredLayoutAttributes = layoutAttributes

        var fittingSize = UIView.layoutFittingCompressedSize
        fittingSize.width = preferredLayoutAttributes.size.width
        let size = contentView.systemLayoutSizeFitting(fittingSize,
                                                       withHorizontalFittingPriority: .required,
                                                       verticalFittingPriority: .defaultLow)
        var adjustedFrame = preferredLayoutAttributes.frame
        adjustedFrame.size.height = ceil(size.height)
        preferredLayoutAttributes.frame = adjustedFrame

//        print("")
//        print("-------------------------------------------------------------------------------")
//        print("LabelCell preferredLayoutAttributesFitting", preferredLayoutAttributes.frame)
//        print("-------------------------------------------------------------------------------")

        return preferredLayoutAttributes
    }
}
