//
//  PassViewController.swift
//  AmusementParkPart2
//
//  Created by redBred LLC on 11/25/16.
//  Copyright © 2016 redBred. All rights reserved.
//

import UIKit

class PassViewController: UIViewController {

    // this enumerations captures the type of swipes that can be
    // performed in this view controller, and associates each of
    // them with the tag of the button in the storyboard
    enum SwipeButtonTag: Int {
        case areaAccess = 0
        case rideAccess
        case discountAccess
    }
    

    
    
    //////////////////////////////////////////////////////////
    // Mark: Outlets
   
    @IBOutlet var resultsLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var passTypeLabel: UILabel!
    @IBOutlet var rideAccessLabel: UILabel!
    @IBOutlet var foodDiscountLabel: UILabel!
    @IBOutlet var merchandiseDiscountLabel: UILabel!
    
    @IBOutlet var roundables: [UIView]!
    
    
    
    
    //////////////////////////////////////////////////////////
    // Mark: Actions

    @IBAction func onTestAccess(_ sender: AnyObject) {
        
        // clear any lingering stuff
        resultsLabel.text = ""
        
        // unwrap curret pass
        if let pass = delegate?.getCurrentPass() {
         
            // convert tag to swipe button enum case
            if let swipeType = SwipeButtonTag(rawValue: sender.tag) {
                switch swipeType {
                case .areaAccess:
                    let result = Area.swipe(pass: pass, silent: false)
                    resultsLabel.text = result.message
                case .rideAccess:
                    let result = RideAccess.swipe(pass: pass, silent: false)
                    resultsLabel.text = result.message
                case .discountAccess:
                    let result = DiscountType.swipe(pass: pass, silent: false)
                    resultsLabel.text = result.message
                }
            }
        }
    }
    
    @IBAction func onCreateNewPass() {
        delegate?.onDismissPassViewController()
    }
    
    
    
    
    var delegate: PassViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        for roundable in roundables {
            roundable.layer.cornerRadius = 10
        }
        
        if let pass = delegate?.getCurrentPass() {
            updateValues(using: pass)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    
    // update all the value on the pass
    func updateValues(using pass: Pass) {
        
        if let firstName = pass.entrant.firstName,
            let lastName = pass.entrant.lastName {
            
            nameLabel.text = "\(firstName) \(lastName)"
        } else {
            nameLabel.text = ""
        }
        
        let passDescription = pass.entrantType.description() + " Pass"
        passTypeLabel.text = passDescription
        
        if let result = RideAccess.swipe(pass: pass, silent: true) as? RideAccess.RideAccessSwipeResult {
            rideAccessLabel.text = result.message
        } else {
            rideAccessLabel.text = ""
        }
        
        
        if let result = DiscountType.food.swipe(pass: pass, silent: true) as? DiscountType.DiscountTypeSwipeResult,
            let amount = result.amount {
            
            foodDiscountLabel.text = "\(amount)% Food Discount"
        } else {
            foodDiscountLabel.text = ""
        }
        
        if let result = DiscountType.merchandise.swipe(pass: pass, silent: true) as? DiscountType.DiscountTypeSwipeResult,
            let amount = result.amount {
            
            merchandiseDiscountLabel.text = "\(amount)% Merch Discount"
        } else {
            merchandiseDiscountLabel.text = ""
        }
    }
}
