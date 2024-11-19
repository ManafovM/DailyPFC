//
//  PFCItem.swift
//  DailyPFC
//
//  Created by マナフォフ・マリフ on 2024/11/18.
//

import Foundation

struct PFCItem: Codable, CustomStringConvertible {
    var food: Food
    var amount: Double
    
    var protein: Double {
        totalPFC(for: food.protein)
    }
    
    var fat: Double {
        totalPFC(for: food.fat)
    }
    
    var carbohydrate: Double {
        totalPFC(for: food.carbohydrate)
    }
    
    var description: String {
        let protein = String(format: "%.1f", protein)
        let fat = String(format: "%.1f", fat)
        let carbohydrate = String(format: "%.1f", carbohydrate)
        return "P: \(protein)  F: \(fat)  C: \(carbohydrate)"
    }
    
    private func totalPFC(for nutrient: Double) -> Double {
        switch food.nutrientsPer {
        case .oneHundredGrams:
            nutrient / 100 * amount
        case .serving:
            nutrient * amount
        }
    }
}
