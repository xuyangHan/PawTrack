//
//  Item.swift
//  PawTrackApp
//
//  Created by Xuyang Han on 2026-04-29.
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
