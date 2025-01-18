//
//  PFCItem.swift
//  DailyPFC
//
//  Created by マナフォフ・マリフ on 2024/11/18.
//

import Foundation

struct PFCItem: Identifiable, Codable, Equatable, CustomStringConvertible {
    var id = UUID()
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
        return "P: \(protein.toString())  F: \(fat.toString())  C: \(carbohydrate.toString())"
    }
    
    private func totalPFC(for nutrient: Double) -> Double {
        switch food.nutrientsPer {
        case .oneHundredGrams:
            nutrient / 100 * amount
        case .serving:
            nutrient * amount
        }
    }
    
    static func ==(lhs: PFCItem, rhs: PFCItem) -> Bool {
        return lhs.id == rhs.id
    }
}
