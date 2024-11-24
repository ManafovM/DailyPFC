//
//  PFCTableViewController.swift
//  DailyPFC
//
//  Created by マナフォフ・マリフ on 2024/11/18.
//

import UIKit

class PFCTableViewController: UITableViewController {
    @IBOutlet weak var currentKcal: UILabel!
    @IBOutlet weak var proteinTotalLabel: UILabel!
    @IBOutlet weak var fatTotalLabel: UILabel!
    @IBOutlet weak var carbohydrateTotalLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = editButtonItem
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = 100.0
        
        DailyPFC.loadDailyPFC()
        updateTotalLabels()
    }
    
    func updateTotalLabels() {
        currentKcal.text = "\(DailyPFC.shared.currentKcal)"
        proteinTotalLabel.text = DailyPFC.shared.proteinTotal.toString()
        fatTotalLabel.text = DailyPFC.shared.fatTotal.toString()
        carbohydrateTotalLabel.text = DailyPFC.shared.carbohydrateTotal.toString()
    }
    
    func updateTotalLabelsWithAnimation() {
        animateNumber(for: currentKcal, from: Double(currentKcal.text!) ?? 0, to: Double(DailyPFC.shared.currentKcal), duration: 0.5)
        animateNumber(for: proteinTotalLabel, from: Double(proteinTotalLabel.text!) ?? 0, to: DailyPFC.shared.proteinTotal, duration: 0.5)
        animateNumber(for: fatTotalLabel, from: Double(fatTotalLabel.text!) ?? 0, to: DailyPFC.shared.fatTotal, duration: 0.5)
        animateNumber(for: carbohydrateTotalLabel, from: Double(carbohydrateTotalLabel.text!) ?? 0, to: DailyPFC.shared.carbohydrateTotal, duration: 0.5)
    }
    
    func animateNumber(for label: UILabel, from start: Double, to end: Double, duration: TimeInterval) {
        let displayLink = CADisplayLink(target: NumberAnimator(from: start, to: end, duration: duration, label: label), selector: #selector(NumberAnimator.update))
        displayLink.add(to: .main, forMode: .default)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DailyPFC.shared.pfcItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PFCItemCell", for: indexPath)
        
        let pfcItem = DailyPFC.shared.pfcItems[indexPath.row]
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
            DailyPFC.shared.pfcItems.remove(at: indexPath.row)
            DailyPFC.saveDailyPFC()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            updateTotalLabelsWithAnimation()
        }
    }
    
    @IBSegueAction func editPfcItem(_ coder: NSCoder, sender: Any?) -> PFCItemDetailViewController? {
        let pfcItemController = PFCItemDetailViewController(coder: coder)
        
        guard let cell = sender as? UITableViewCell,
              let indexPath = tableView.indexPath(for: cell) else {
            return pfcItemController
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        pfcItemController?.pfcItem = DailyPFC.shared.pfcItems[indexPath.row]
        
        return pfcItemController
    }
    
    @IBAction func unwindToPFCItems(segue: UIStoryboardSegue) {
        guard segue.identifier == "savePFCItem" else { return }
        let sourceViewController = segue.source as! PFCItemDetailViewController
        if let pfcItem = sourceViewController.pfcItem {
            if let indexOfExistingPfcItem = DailyPFC.shared.pfcItems.firstIndex(of: pfcItem) {
                DailyPFC.shared.pfcItems[indexOfExistingPfcItem] = pfcItem
                tableView.reloadRows(at: [IndexPath(row: indexOfExistingPfcItem, section: 0)], with: .automatic)
            } else {
                let newIndexPath = IndexPath(row: DailyPFC.shared.pfcItems.count, section: 0)
                DailyPFC.shared.pfcItems.append(pfcItem)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
            DailyPFC.saveDailyPFC()
            updateTotalLabelsWithAnimation()
        }
    }
}

class NumberAnimator {
    private let startValue: Double
    private let endValue: Double
    private let duration: TimeInterval
    private let label: UILabel
    private let startTime: CFTimeInterval
    private var displayLink: CADisplayLink?
    
    init(from start: Double, to end: Double, duration: TimeInterval, label: UILabel) {
        self.startValue = start
        self.endValue = end
        self.duration = duration
        self.label = label
        self.startTime = CACurrentMediaTime()
    }
    
    @objc func update(displayLink: CADisplayLink) {
        let elapsed = CACurrentMediaTime() - startTime
        if elapsed >= duration {
            label.text = endValue.toString()
            displayLink.invalidate()
            return
        }
        let progress = elapsed / duration
        let currentValue = Double(startValue + progress * endValue - startValue)
        label.text = currentValue.toString()
    }
}
