//
//  MovementDetailViewController.swift
//  PR2
//
//  Copyright © 2018 UOC. All rights reserved.
//

import UIKit

class MovementDetailViewController: UIViewController {
    // BEGIN-UOC-5
    var movement: Movement!
    
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var valueDateLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
    // END-UOC-5
    
    override func viewDidLoad() {
        // BEGIN-UOC-6.2
        super.viewDidLoad()

        // Set amount
        amountLabel.text = String(format: "%.2f €", (movement.amount.description as NSString).doubleValue).replacingOccurrences(of: ".", with: ",")
        
        // Set red color to negative amounts
        if(movement.amount < 0){
            amountLabel.textColor = UIColor.red;
        } else {
            amountLabel.textColor = UIColor.black;
        }
        
        // Set description
        descriptionLabel.text = movement.movementDescription
        
        // Set date and value date
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        dateLabel.text = formatter.string(from: movement.date)
        valueDateLabel.text = formatter.string(from: movement.valueDate)
        
        // Set balance
        balanceLabel.text = String(format: "%.2f €", (movement.balance.description as NSString).doubleValue).replacingOccurrences(of: ".", with: ",")
        // END-UOC-6.2
    }
    
    // BEGIN-UOC-7
    func rejectAction(sender: UIButton!) {        
        if let navigationController = self.navigationController {
            navigationController.popViewController(animated: true)
        }
    }
    // END-UOC-7    
}
