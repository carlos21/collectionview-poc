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
    
    @IBOutlet weak var textView: UITextView!
    
    func configure(label: String, color: UIColor) {
        textView.backgroundColor = .clear
        textView.isEditable = false
        textView.text = label
        textView.font = UIFont.systemFont(ofSize: 15)
        contentView.backgroundColor = color
    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
////        contentView.pin.all(pin.safeArea)
//        textView.pin.top(16).bottom(16).horizontally(16).sizeToFit(.widthFlexible)
//        contentView.pin.height(textView.frame.maxY + 16)
//    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        let preferredLayoutAttributes = layoutAttributes
        let height = textView.text.heightWithConstrainedWidth(width: layoutAttributes.size.width, font: UIFont.systemFont(ofSize: 15)) + 32
        preferredLayoutAttributes.size.height = height
        return preferredLayoutAttributes
//        setNeedsLayout()
//        layoutIfNeeded()
//
//        let preferredLayoutAttributes = layoutAttributes
//
//        var fittingSize = UIView.layoutFittingCompressedSize
//        fittingSize.width = preferredLayoutAttributes.size.width
//        let size = contentView.systemLayoutSizeFitting(fittingSize,
//                                                       withHorizontalFittingPriority: .required,
//                                                       verticalFittingPriority: .defaultLow)
//        var adjustedFrame = preferredLayoutAttributes.frame
//        adjustedFrame.size.height = titleLabel.frame.size.height + 32
//        preferredLayoutAttributes.frame = adjustedFrame
//
////        print("")
////        print("-------------------------------------------------------------------------------")
////        print("LabelCell preferredLayoutAttributesFitting", preferredLayoutAttributes.frame)
////        print("-------------------------------------------------------------------------------")
//
//        return preferredLayoutAttributes
    }
}
