//
//  SelectFoodViewController.swift
//  DailyPFC
//
//  Created by マナフォフ・マリフ on 2024/11/19.
//

import UIKit

class SelectFoodViewController: UITableViewController {
    var delegate: SelectFoodViewControllerDelegate?
    var food: Food?

    override func viewDidLoad() {
        super.viewDidLoad()
        FoodList.loadFoodList()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FoodList.shared.foodList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SelectFoodCell", for: indexPath)
        let food = FoodList.shared.foodList[indexPath.row]

        var content = cell.defaultContentConfiguration()
        content.text = food.name
        content.secondaryText = food.description
        cell.contentConfiguration = content
        
        if food == self.food {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let food = FoodList.shared.foodList[indexPath.row]
        self.food = food
        delegate?.selectFoodViewController(self, didSelect: food)
        tableView.reloadData()
    }
}

protocol SelectFoodViewControllerDelegate: AnyObject {
    func selectFoodViewController(_ controller: SelectFoodViewController, didSelect food: Food)
}
