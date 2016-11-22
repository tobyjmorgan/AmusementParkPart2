//
//  ViewController.swift
//  AmusementParkPart2
//
//  Created by redBred LLC on 11/20/16.
//  Copyright © 2016 redBred. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var containerGeneratePassButton: UIView!
    @IBOutlet var containerPopulateDataButton: UIView!
    
    @IBOutlet var allLabels: [UILabel]!
    @IBOutlet var allFields: [UITextField]!
    
    @IBOutlet var entrantTypeStackView: UIStackView!
    @IBOutlet var entrantSubTypeStackView: UIStackView!
    
    
    
    @IBAction func onGeneratePass() {
        // gather up personal details
        
    }
    
    @IBAction func onPopulateData() {
    }
    
    @IBAction func onEntrantType(_ sender: AnyObject) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // round the corners of the bottom buttons
        containerGeneratePassButton.layer.cornerRadius = 10.0
        containerPopulateDataButton.layer.cornerRadius = 10.0
        
        EntrantType.employee(.hourlyFoodServices).getEnablementPolicy().applyPolicy(to: allLabels)
        EntrantType.employee(.hourlyFoodServices).getEnablementPolicy().applyPolicy(to: allFields)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

