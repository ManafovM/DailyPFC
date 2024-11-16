//
//  Food.swift
//  DailyPFC
//
//  Created by マナフォフ・マリフ on 2024/11/16.
//

import Foundation

struct Food: Codable {
    var name: String
    var protein: Double
    var fat: Double
    var carbohydrate: Double
    var nutrientsPer: NutrientsPer
}

enum NutrientsPer: Codable {
    case oneHundredGrams
    case serving
}
