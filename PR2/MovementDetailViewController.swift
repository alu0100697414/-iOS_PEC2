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
    override func viewWillAppear(_ animated: Bool) {
        // Set button if movement is false
        if(movement.rejected == false){
            // Create button
            let button = makeButton()
            view.addSubview(button)
            
            // Set constraints to button
            addContrainsts(component: button)
        } else {
            // Set label of the rejected movement
            let label = makeLabel()
            view.addSubview(label)
            
            // Set constraints to label
            addContrainsts(component: label)
        }
    }
    
    @objc func rejectAction(sender: UIButton!) {
        if let navigationController = self.navigationController {
            navigationController.popViewController(animated: true)
        }
    
        // Set rejected true
        movement.rejected = true
    }
    
    func makeButton() -> UIButton {
        // Create reject button
        let button = UIButton(type: UIButtonType.system)
        button.frame = CGRect(x: 0, y: 0, width: 75, height: 25)
        
        // Set title
        button.setTitle("Reject", for: .normal)
        
        // Set title color
        button.setTitleColor(self.view.tintColor, for: .normal)
        
        // Set action
        button.addTarget(self, action: #selector(rejectAction), for: .touchUpInside)
        
        return button
    }
    
    func makeLabel() -> UILabel {
        // Create rejected label
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: 75, height: 25)
        
        // Set title
        label.text = "Rejected"
        
        // Set text color
        label.textColor = UIColor.red
        
        return label
    }
    
    func addContrainsts(component: UIView){
        component.translatesAutoresizingMaskIntoConstraints = false
        
        // Top constraint
        let top = NSLayoutConstraint(item: component, attribute: .topMargin, relatedBy: .equal,
                                    toItem: balanceLabel, attribute: .bottom, multiplier: 1.0,
                                    constant: 20)
        // Center constraint
        let centered = NSLayoutConstraint(item: component, attribute: .centerX, relatedBy: .equal,
                                        toItem: view, attribute: .centerX, multiplier: 1.0,
                                        constant: 0)
        // Add constraints
        view.addConstraints([top, centered])
    }
    // END-UOC-7    
}
