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
}
