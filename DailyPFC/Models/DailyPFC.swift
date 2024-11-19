//
//  DailyPFC.swift
//  DailyPFC
//
//  Created by マナフォフ・マリフ on 2024/11/19.
//

import Foundation

struct DailyPFC: Codable {
    static var shared = DailyPFC(pfcItems:[
        PFCItem(food: Food(name: "Rice", protein: 2.5, fat: 0.3, carbohydrate: 37.1, nutrientsPer: .oneHundredGrams), amount: 180)
    ], maxKcal: 2209)
    
    static let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let archiveURL = documentsDirectory.appendingPathComponent("dailyPfc").appendingPathExtension("plist")
    
    var pfcItems: [PFCItem]
    var maxKcal: Int
    
    var proteinTotal: Double {
        pfcItems.reduce(0.0, { $0 + $1.protein })
    }
    
    var fatTotal: Double {
        pfcItems.reduce(0.0, { $0 + $1.fat })
    }
    
    var carbohydrateTotal: Double {
        pfcItems.reduce(0.0, { $0 + $1.carbohydrate })
    }
    
    var currentKcal: Int {
        Int((proteinTotal + carbohydrateTotal) * 4 + fatTotal * 9)
    }
    
    static func saveDailyPFC() {
        let propertyListEncoder = PropertyListEncoder()
        let codedData = try? propertyListEncoder.encode(self.shared)
        try? codedData?.write(to: archiveURL)
    }
    
    static func loadDailyPFC() {
        guard let codedData = try? Data(contentsOf: archiveURL) else { return }
        let propertyListDecoder = PropertyListDecoder()
        if let loadedDailyPfc = try? propertyListDecoder.decode(self, from: codedData) {
            self.shared = loadedDailyPfc
        }
    }
}
