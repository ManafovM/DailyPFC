//
//  PFCItemDetailViewController.swift
//  DailyPFC
//
//  Created by マナフォフ・マリフ on 2024/11/19.
//

import UIKit

class PFCItemDetailViewController: UITableViewController, SelectFoodViewControllerDelegate {
    var pfcItem: PFCItem?
    var food: Food?

    @IBOutlet weak var foodNameLabel: UILabel!
    @IBOutlet weak var foodAmountField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        update()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard segue.identifier == "savePFCItem",
              let food else { return }
        let amount = foodAmountField.text?.toDouble() ?? 0
        
        if pfcItem != nil {
            pfcItem?.amount = amount
            pfcItem?.food = food
        } else {
            pfcItem = PFCItem(food: food, amount: amount)
        }
    }
    
    func selectFoodViewController(_ controller: SelectFoodViewController, didSelect food: Food) {
        self.food = food
        foodNameLabel.text = food.name
        updateAmountTextFieldPlaceholder(food: food)
    }
    
    func update() {
        if let pfcItem {
            navigationItem.title = "Edit"
            food = pfcItem.food
            foodNameLabel.text = food?.name
            foodAmountField.text = pfcItem.amount.toString()
            updateAmountTextFieldPlaceholder(food: pfcItem.food)
        } else {
            navigationItem.title = "New"
            foodNameLabel.text = "Not Set"
        }
    }
    
    func updateAmountTextFieldPlaceholder(food: Food) {
        switch food.nutrientsPer {
        case .oneHundredGrams:
            foodAmountField.placeholder = "Amount (grams)"
        case .serving:
            foodAmountField.placeholder = "Amount (servings)"
        }
    }
    
    @IBSegueAction func selectFood(_ coder: NSCoder) -> SelectFoodViewController? {
        let selectFoodViewController = SelectFoodViewController(coder: coder)
        selectFoodViewController?.delegate = self
        selectFoodViewController?.food = food
        return selectFoodViewController
    }
}
