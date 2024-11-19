//
//  PFCTableViewController.swift
//  DailyPFC
//
//  Created by マナフォフ・マリフ on 2024/11/18.
//

import UIKit

class PFCTableViewController: UITableViewController {
    var dailyPfc = DailyPFC(pfcItems:[
        PFCItem(food: Food(name: "Rice", protein: 2.5, fat: 0.3, carbohydrate: 37.1, nutrientsPer: .oneHundredGrams), amount: 180)
    ], maxKcal: 2209)
    
    @IBOutlet weak var proteinTotalLabel: UILabel!
    @IBOutlet weak var fatTotalLabel: UILabel!
    @IBOutlet weak var carbohydrateTotalLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = editButtonItem
        updateTotalLabels()
    }
    
    func updateTotalLabels() {
        proteinTotalLabel.text = String(format: "%.1f", dailyPfc.proteinTotal)
        fatTotalLabel.text = String(format: "%.1f", dailyPfc.fatTotal)
        carbohydrateTotalLabel.text = String(format: "%.1f", dailyPfc.carbohydrateTotal)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dailyPfc.pfcItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PFCItemCell", for: indexPath)
        
        let pfcItem = dailyPfc.pfcItems[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = pfcItem.food.name
        content.secondaryText = pfcItem.description
        cell.contentConfiguration = content

        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            dailyPfc.pfcItems.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            updateTotalLabels()
        }
    }
    
    @IBAction func unwindToPFCItems(segue: UIStoryboardSegue) {
        guard segue.identifier == "savePFCItem" else { return }
        let sourceViewController = segue.source as! PFCItemDetailViewController
        if let pfcItem = sourceViewController.pfcItem {
            let newIndexPath = IndexPath(row: dailyPfc.pfcItems.count, section: 0)
            dailyPfc.pfcItems.append(pfcItem)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
            updateTotalLabels()
        }
    }
}
