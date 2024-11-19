//
//  Food.swift
//  DailyPFC
//
//  Created by マナフォフ・マリフ on 2024/11/16.
//

import Foundation

struct Food: Codable, CustomStringConvertible, Equatable {
    var name: String
    var protein: Double
    var fat: Double
    var carbohydrate: Double
    var nutrientsPer: NutrientsPer
    
    var description: String {
        "P: \(protein)  F: \(fat)  C: \(carbohydrate) per \(nutrientsPer.rawValue)"
    }
}

enum NutrientsPer: String, Codable {
    case oneHundredGrams = "100g"
    case serving = "serving"
}
