//
//  FoodTableViewController.swift
//  DailyPFC
//
//  Created by マナフォフ・マリフ on 2024/11/16.
//

import UIKit

class FoodTableViewController: UITableViewController {
    var foodList = [
        Food(name: "白米", protein: 1.0, fat: 1.0, carbohydrate: 1.0, nutrientsPer: .oneHundredGrams),
        Food(name: "ポカリ", protein: 0.0, fat: 0.0, carbohydrate: 1.0, nutrientsPer: .oneHundredGrams),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FoodCell", for: indexPath)

        let food = foodList[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = food.name
        content.secondaryText = "P: \(food.protein)  F: \(food.fat)  C: \(food.carbohydrate)"
        cell.contentConfiguration = content

        return cell
    }

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            foodList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    @IBAction func unwindToFoodList(segue: UIStoryboardSegue) {
        guard segue.identifier == "saveFood" else { return }
        let sourceViewController = segue.source as! FoodDetailViewController
        if let food = sourceViewController.food {
            let newIndexPath = IndexPath(row: foodList.count, section: 0)
            foodList.append(food)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
    }
}
