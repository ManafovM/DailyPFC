//
//  PFCTableViewController.swift
//  DailyPFC
//
//  Created by マナフォフ・マリフ on 2024/11/18.
//

import UIKit

class PFCTableViewController: UITableViewController {
    var pfcItems = [
        PFCItem(food: Food(name: "白米", protein: 1.0, fat: 1.0, carbohydrate: 1.0, nutrientsPer: .oneHundredGrams), amount: 180)
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
        return pfcItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PFCItemCell", for: indexPath)
        
        let pfcItem = pfcItems[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = pfcItem.food.name
        content.secondaryText = "P: \(pfcItem.protein)  F: \(pfcItem.fat)  C: \(pfcItem.carbohydrate)"
        cell.contentConfiguration = content

        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            pfcItems.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    @IBAction func unwindToPFCItems(segue: UIStoryboardSegue) {
        guard segue.identifier == "savePFCItem" else { return }
        let sourceViewController = segue.source as! PFCItemDetailViewController
        if let pfcItem = sourceViewController.pfcItem {
            let newIndexPath = IndexPath(row: pfcItems.count, section: 0)
            pfcItems.append(pfcItem)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
    }
}
