//
//  FoodTableViewController.swift
//  DailyPFC
//
//  Created by マナフォフ・マリフ on 2024/11/16.
//

import UIKit

class FoodTableViewController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "FoodCell", for: indexPath)

        let food = FoodList.shared.foodList[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = food.name
        content.secondaryText = food.description
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
            FoodList.shared.foodList.remove(at: indexPath.row)
            FoodList.saveFoodList()
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    @IBAction func unwindToFoodList(segue: UIStoryboardSegue) {
        guard segue.identifier == "saveFood" else { return }
        let sourceViewController = segue.source as! FoodDetailViewController
        if let food = sourceViewController.food {
            let newIndexPath = IndexPath(row: FoodList.shared.foodList.count, section: 0)
            FoodList.shared.foodList.append(food)
            FoodList.saveFoodList()
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
    }
}
