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
    }
    
    @IBAction func onPopulateData() {
    }
    
    @IBAction func onEntrantType(_ sender: AnyObject) {
    }
    
    enum DataEntryTags: Int {
        case none
        case dateOfBirth
        case ssn
        case projectNumber
        case firstName
        case lastName
        case company
        case streetAddress
        case city
        case state
        case zipCode
    }
    
    let aPolicy = DataEntryPolicy(enabledTags: [DataEntryTags.dateOfBirth.rawValue, DataEntryTags.firstName.rawValue])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        aPolicy.applyPolicy(to: allLabels)
        aPolicy.applyPolicy(to: allFields)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

