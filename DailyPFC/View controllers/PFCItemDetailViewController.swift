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
        
        updateNavigationItem()
        updateFoodNameLabel()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard segue.identifier == "savePFCItem" else { return }
        let amount = Double(foodAmountField.text!) ?? 0
        
        if pfcItem != nil {
            return
        } else if let food {
            pfcItem = PFCItem(food: food, amount: amount)
        }
    }
    
    func selectFoodViewController(_ controller: SelectFoodViewController, didSelect food: Food) {
        self.food = food
        updateFoodNameLabel()
    }
    
    func updateFoodNameLabel() {
        if let food {
            foodNameLabel.text = food.name
        } else {
            foodNameLabel.text = "Not Set"
        }
    }
    
    func updateNavigationItem() {
        if let pfcItem {
            navigationItem.title = "Edit"
        } else {
            navigationItem.title = "New"
        }
    }
    
    @IBSegueAction func selectFood(_ coder: NSCoder) -> SelectFoodViewController? {
        let selectFoodViewController = SelectFoodViewController(coder: coder)
        selectFoodViewController?.delegate = self
        selectFoodViewController?.food = food
        return selectFoodViewController
    }
}
