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
    @IBOutlet weak var nutrientsPerControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard segue.identifier == "saveFood" else { return }
        let name = nameField.text ?? ""
        let protein = Double(proteinField.text!) ?? 0.0
        let fat = Double(fatField.text!) ?? 0.0
        let carbohydrate = Double(carbohydrateField.text!) ?? 0.0
        
        let selectedSegmentTitle = nutrientsPerControl.titleForSegment(at: nutrientsPerControl.selectedSegmentIndex) ?? "100g"
        let nutrientsPer = NutrientsPer(rawValue: selectedSegmentTitle) ?? .oneHundredGrams
        
        if food != nil {
            food?.name = name
            food?.protein = protein
            food?.fat = fat
            food?.carbohydrate = carbohydrate
            food?.nutrientsPer = nutrientsPer
        } else {
            food = Food(name: name, protein: protein, fat: fat, carbohydrate: carbohydrate, nutrientsPer: nutrientsPer)
        }
    }
    
    func updateUI() {
        if let food {
            navigationItem.title = "Edit"
            nameField.text = food.name
            proteinField.text = "\(food.protein)"
            fatField.text = "\(food.fat)"
            carbohydrateField.text = "\(food.carbohydrate)"
            nutrientsPerControl.selectedSegmentIndex = (0..<nutrientsPerControl.numberOfSegments)
                .first(where: { nutrientsPerControl.titleForSegment(at: $0) == food.nutrientsPer.rawValue })!
        } else {
            navigationItem.title = "New"
        }
    }
}
