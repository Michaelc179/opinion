//
//  Item.swift
//  opinion
//
//  Created by Michael Chen on 1/20/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
