//
//  Food.swift
//  DailyPFC
//
//  Created by マナフォフ・マリフ on 2024/11/16.
//

import Foundation

struct Food: Identifiable, Codable, CustomStringConvertible, Equatable {
    var id = UUID()
    var name: String
    var protein: Double
    var fat: Double
    var carbohydrate: Double
    var nutrientsPer: NutrientsPer
    
    var description: String {
        "P: \(protein.toString())  F: \(fat.toString())  C: \(carbohydrate.toString()) per \(nutrientsPer.rawValue)"
    }
    
    static func ==(lhs: Food, rhs: Food) -> Bool {
        return lhs.id == rhs.id
    }
}

enum NutrientsPer: String, Codable {
    case oneHundredGrams = "100g"
    case serving = "serving"
}

extension Double {
    func toString() -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .decimal
        formatter.usesGroupingSeparator = false
        formatter.maximumFractionDigits = 1
        formatter.minimumFractionDigits = 0
        return formatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }
}

extension String {
    func toDouble() -> Double? {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .decimal
        return formatter.number(from: self)?.doubleValue
    }
}
