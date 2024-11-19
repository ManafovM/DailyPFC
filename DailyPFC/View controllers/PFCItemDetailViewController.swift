//
//  PFCItemDetailViewController.swift
//  DailyPFC
//
//  Created by マナフォフ・マリフ on 2024/11/19.
//

import UIKit

class PFCItemDetailViewController: UITableViewController {
    var pfcItem: PFCItem?

    @IBOutlet weak var foodNameLabel: UILabel!
    @IBOutlet weak var foodAmountField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let pfcItem {
            navigationItem.title = "Edit"
        } else {
            navigationItem.title = "New"
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard segue.identifier == "savePFCItem" else { return }
        let food = Food(name: "白米", protein: 1.0, fat: 1.0, carbohydrate: 1.0, nutrientsPer: .oneHundredGrams)
        let amount = Int(foodAmountField.text!) ?? 0
        
        if pfcItem != nil {
            return
        } else {
            pfcItem = PFCItem(food: food, amount: amount)
        }
    }
}
