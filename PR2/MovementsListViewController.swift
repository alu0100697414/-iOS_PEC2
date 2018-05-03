//
//  MovementsListViewController.swift
//  PR2
//
//  Copyright © 2018 UOC. All rights reserved.
//

import UIKit

class MovementsListViewController: UITableViewController {
    // BEGIN-UOC-1
    
    var movements: [Movement]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        tableView.rowHeight = 75
        
        movements = Services.getMovements()
    }
    // END-UOC-1
    

    
    
    // BEGIN-UOC-3
    override func numberOfSections(in tableView: UITableView) -> Int {
        // Return number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return number of rows
        return movements.count + 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // If it is the last row
        if(indexPath.row == movements.count){
            return tableView.dequeueReusableCell(withIdentifier: "LastMovementCell", for: indexPath)
        }
        // Set movement
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MovementCell", for: indexPath) as! MovementCell
            
            // Check if movement is rejected
            if(movements[indexPath.row].rejected == true){
                cell.backgroundColor = UIColor.orange.lighter()
            } else {
                cell.backgroundColor = UIColor.white
            }
            
            // Set description
            cell.descriptionLabel.text = movements[indexPath.row].movementDescription
            
            // Set date
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            cell.dateLabel.text = formatter.string(from: movements[indexPath.row].date)
            
            // Set amount
            cell.amountLabel.text = String(format: "%.2f €", (movements[indexPath.row].amount.description as NSString).doubleValue).replacingOccurrences(of: ".", with: ",")
            
            // Set red color to negative amounts
            if(movements[indexPath.row].amount < 0){
                cell.amountLabel.textColor = UIColor.red;
            } else {
                cell.amountLabel.textColor = UIColor.black;
            }
            
            return cell
        }
    }
    // END-UOC-3
    
    // BEGIN-UOC-5
    @IBOutlet weak var segmentedFilter: UISegmentedControl!
    @IBAction func segmentedFilterAction(_ sender: UISegmentedControl) {
        // All movements
        if(sender.selectedSegmentIndex == 0){
            // Set all movements
            movements = Services.getMovements()
        }
        // Get only today movements
        else if(sender.selectedSegmentIndex == 1){
            // Get current date
            let date = Date()
            
            // Save only today movements
            var todayMovements = [Movement]()
            for movement in movements {
                if (Calendar.current.compare(movement.date, to: date, toGranularity: .day) == .orderedSame) {
                    todayMovements.append(movement)
                }
            }
            
            // Save today movements
            movements = todayMovements
        }
        
        tableView.reloadData()
    }
    // END-UOC-5
    
    // BEGIN-UOC-6.1
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.destination is MovementDetailViewController) {
            // Set current movement in MovementDetailViewController
            let object = segue.destination as? MovementDetailViewController
            object?.movement = movements[(tableView.indexPathForSelectedRow?.row)!]
        }
    }
    // END-UOC-6.1
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
}
