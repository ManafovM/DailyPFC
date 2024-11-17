//
//  FoodDetailViewController.swift
//  DailyPFC
//
//  Created by マナフォフ・マリフ on 2024/11/17.
//

import UIKit

class FoodDetailViewController: UITableViewController {
    var food: Food?
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var proteinField: UITextField!
    @IBOutlet weak var fatField: UITextField!
    @IBOutlet weak var carbohydrateField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let food {
            navigationItem.title = "Edit"
        } else {
            navigationItem.title = "New"
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard segue.identifier == "saveFood" else { return }
        let name = nameField.text ?? ""
        let protein = Double(proteinField.text!) ?? 0.0
        let fat = Double(fatField.text!) ?? 0.0
        let carbohydrate = Double(carbohydrateField.text!) ?? 0.0
        
        if food != nil {
            return
        } else {
            food = Food(name: name, protein: protein, fat: fat, carbohydrate: carbohydrate, nutrientsPer: .serving)
        }
    }
}
