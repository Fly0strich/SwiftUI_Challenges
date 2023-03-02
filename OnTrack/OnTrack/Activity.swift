//
//  Activity.swift
//  OnTrack
//
//  Created by Shae Willes on 9/1/22.
//

import Foundation

struct Activity: Identifiable, Codable, Equatable {
    var id = UUID()
    var name: String
    var description: String
    var counter: Int
}

class Activities: ObservableObject {
    @Published var items = [Activity]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([Activity].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        items = []
    }
}
