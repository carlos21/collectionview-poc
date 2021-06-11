//
//  ItemViewModel.swift
//  CollectionViewPOC
//
//  Created by Carlos Duclos on 10/06/21.
//

import Foundation
import UIKit

class ItemViewModel {
    
    var title: String
    var description: String
    var displayedText: String {
        return isExpanded ? description : title
    }
    var isExpanded: Bool = false
    var color: UIColor = .white
    
    init(title: String, description: String, color: UIColor) {
        self.title = title
        self.description = description
        self.color = color
    }
    
    func toggle() {
        isExpanded = !isExpanded
    }
    
    func calculateHeight(for width: CGFloat) -> CGFloat {
//        let textView = UITextView()
//        textView.text = displayedText
//        textView.pin.top(16).bottom(16).horizontally(16).sizeToFit(.)
////        label.pin.layout()
        let height = displayedText.heightWithConstrainedWidth(width: width, font: UIFont.systemFont(ofSize: 15)) + 32
//        print(height)
//        print(displayedText)
        return height
    }
}
