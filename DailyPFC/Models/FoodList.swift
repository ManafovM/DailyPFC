//
//  FoodList.swift
//  DailyPFC
//
//  Created by マナフォフ・マリフ on 2024/11/19.
//

import Foundation

struct FoodList: Codable {
    static var shared = FoodList()
    
    static let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let archiveURL = documentsDirectory.appendingPathComponent("foodList").appendingPathExtension("plist")
    
    static func saveFoodList() {
        let propertyListEncoder = PropertyListEncoder()
        let codedData = try? propertyListEncoder.encode(self.shared.foodList)
        try? codedData?.write(to: archiveURL)
    }
    
    static func loadFoodList() {
        guard let codedData = try? Data(contentsOf: archiveURL) else { return }
        let propertyListDecoder = PropertyListDecoder()
        if let loadedFoodList = try? propertyListDecoder.decode(Array<Food>.self, from: codedData) {
            self.shared.foodList = loadedFoodList
        }
    }
    
    var foodList = [
        Food(name: "Rice", protein: 2.5, fat: 0.3, carbohydrate: 37.1, nutrientsPer: .oneHundredGrams),
        Food(name: "Pocari", protein: 0.0, fat: 0.0, carbohydrate: 6.2, nutrientsPer: .oneHundredGrams),
    ]
}
