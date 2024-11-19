//
//  DailyPFC.swift
//  DailyPFC
//
//  Created by マナフォフ・マリフ on 2024/11/19.
//

import Foundation

struct DailyPFC: Codable {
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
}
