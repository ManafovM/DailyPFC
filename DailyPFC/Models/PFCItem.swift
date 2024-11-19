//
//  PFCItem.swift
//  DailyPFC
//
//  Created by マナフォフ・マリフ on 2024/11/18.
//

import Foundation

struct PFCItem: Codable {
    var food: Food
    var amount: Int
    
    var protein: Double {
        totalPFC(for: food.protein)
    }
    
    var fat: Double {
        totalPFC(for: food.fat)
    }
    
    var carbohydrate: Double {
        totalPFC(for: food.carbohydrate)
    }
    
    private func totalPFC(for nutrient: Double) -> Double {
        switch food.nutrientsPer {
        case .oneHundredGrams:
            nutrient / 100 * Double(amount)
        case .serving:
            nutrient * Double(amount)
        }
    }
}
