//
//  ViewController.swift
//  AmusementParkPart2
//
//  Created by redBred LLC on 11/20/16.
//  Copyright © 2016 redBred. All rights reserved.
//

import UIKit

class ViewController: UIViewController, PassViewControllerDelegate {
    
    var sounds = SoundManager()
    var model = Model()
    var masterTypeButtons: [UIButton] = []
    var subTypeButtons: [UIButton] = []
    let entrantButtonColors = ButtonHighlightPolicy(highlightColor: UIColor.white, unhighlightColor: UIColor.lightGray)

    
    
    
    //////////////////////////////////////////////////////////
    // Mark: Outlets

    @IBOutlet var containerGeneratePassButton: UIView!
    @IBOutlet var containerPopulateDataButton: UIView!
    
    @IBOutlet var allLabels: [UILabel]!
    @IBOutlet var allFields: [UITextField]!
    
    @IBOutlet var entrantTypeStackView: UIStackView!
    @IBOutlet var entrantSubTypeStackView: UIStackView!
    
    @IBOutlet var bottomLayoutConstraint: NSLayoutConstraint!
    
    @IBOutlet var lowerButtonStackView: UIStackView!
    @IBOutlet var lowerButtonStackViewBottomConstraint: NSLayoutConstraint!
    
    
    
    
    //////////////////////////////////////////////////////////
    // Mark: Actions

    @IBAction func onGeneratePass() {
       
        model.currenPass = nil
        
        do {

            // try to create a pass with the supplied information
            let pass = try PassGenerator.generatePass(applicant: copyFormToPersonalDetails(), entrantType: model.activeEntrantType)
            
            // set it to the model's current pass
            model.currenPass = pass
            
            // launch the segue to the pass view controller
            performSegue(withIdentifier: "PassSegue", sender: nil)
            
        } catch PassGenerator.PassGeneratorError.missingInformation(let message) {
            reportError(message: "\(message) is a required field.")
        } catch PassGenerator.PassGeneratorError.invalidInformation(let message) {
            reportError(message: "Invalid value - \(message).")
        } catch PassGenerator.PassGeneratorError.excessivelyLongValue(let message) {
            reportError(message: "\(message): value too long.")
        } catch PassGenerator.PassGeneratorError.entrantSubTypeDoesNotRelateToMasterType {
            reportError(message: "The entrant sub-type does not relate to the entrant master-type.")
        } catch PassGenerator.PassGeneratorError.doesNotQualify(let message) {
            reportError(message: message)
        } catch {
            reportError(message: "There was an unknown problem trying to generate a pass.")
        }
        
    }
    
    @IBAction func onPopulateData() {
        let details = model.activeEntrantType.getPrePopulatedData()
        
        copyPersonalDetailsToForm(details: details)
    }
    
    

    
    //////////////////////////////////////////////////////////
    // Mark: Utility functions
    
    func getMatchingLabelText(tag: DataEntryTag) -> String? {
        for label in allLabels {
            if label.tag == tag.rawValue {
                
                if label.text != nil {
                    return label.text
                }
            }
        }
        
        return nil
    }
    
    // takes all the data entered and places it on a single RawPersonalDetails
    // object ready for passing to the Pass generator
    func copyFormToPersonalDetails() -> RawPersonalDetails {
        
        // create a personal details object ready for adding details
        var details = RawPersonalDetails()
        
        // get the data entry policy for the master/sub type combination
        let policy = model.activeEntrantType.getEnablementPolicy()
        
        // gather up personal details
        for field in allFields {
            
            // check if this field is required by the data entry policy
            if policy.enabledTags.contains(field.tag) {
                
                // convert the tag in to a data entry enumeration case
                // makes the switch more readable
                if let dataEntryTag = DataEntryTag(rawValue: field.tag) {
                    
                    let textValue = field.text
                    
                    // copy the values to the personal details object
                    switch dataEntryTag {
                    case .firstName:
                        details.firstName = textValue
                    case .lastName:
                        details.lastName = textValue
                    case .streetAddress:
                        details.street = textValue
                    case .city:
                        details.city = textValue
                    case .state:
                        details.state = textValue
                    case .zipCode:
                        details.zipCode = textValue
                    case .company:
                        details.companyName = textValue
                    case .projectNumber:
                        details.projectNumber = textValue
                    case .ssn:
                        details.socialSecurityNumber = textValue
                    case .dateOfBirth:
                        details.dateOfBirth = textValue
                    }
                }
            }
        }
        
        return details
    }
    
    // used when pre-populating takes generated data and assigns the values
    func copyPersonalDetailsToForm(details: RawPersonalDetails) {
        
        // get the data entry policy for the master/sub type combination
        let policy = model.activeEntrantType.getEnablementPolicy()
        
        // iterate through the fields
        for field in allFields {
            
            // check if this field is required by the data entry policy
            if policy.enabledTags.contains(field.tag) {
                
                // convert the tag in to a data entry enumeration case
                // makes the switch more readable
                if let dataEntryTag = DataEntryTag(rawValue: field.tag) {
                    
                    // copy the values from the personal details object
                    switch dataEntryTag {
                    case .firstName:
                        field.text = details.firstName
                    case .lastName:
                        field.text = details.lastName
                    case .streetAddress:
                        field.text = details.street
                    case .city:
                        field.text = details.city
                    case .state:
                        field.text = details.state
                    case .zipCode:
                        field.text = details.zipCode
                    case .company:
                        field.text = details.companyName
                    case .projectNumber:
                        field.text = details.projectNumber
                    case .ssn:
                        field.text = details.socialSecurityNumber
                    case .dateOfBirth:
                        field.text = details.dateOfBirth
                    }
                }
            }
        }
    }
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // round the corners of the bottom buttons
        containerGeneratePassButton.layer.cornerRadius = 10.0
        containerPopulateDataButton.layer.cornerRadius = 10.0
        
        createMasterTypeButtons()
        
        // listen for keyboard show/hide events
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardNotification(notification:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
   //////////////////////////////////////////////////////////
    // Mark: Keyboard handling
    func keyboardNotification(notification: NSNotification) {
        
        // fetch the user dictionary and get thewhat will be the keyboards frame
        guard let userInfo = notification.userInfo,
            let endFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
                return
        }
        
        if endFrame.origin.y >= UIScreen.main.bounds.size.height {
            // keyboard is being hidden so restore the bottom constraint
            UIView.animate(withDuration: 0.8) {
                self.bottomLayoutConstraint.constant = 0
                self.view.layoutIfNeeded()
            }
        } else {
            // keyboard is about to be shown so slide up the nested view
            // by increasing the layout constraint's constant value
            // subtract the height of the buttons and its bottom constraint
            UIView.animate(withDuration: 0.8) {
                self.bottomLayoutConstraint.constant = endFrame.size.height - self.lowerButtonStackView.frame.size.height - self.lowerButtonStackViewBottomConstraint.constant
                self.view.layoutIfNeeded()
            }
        }
    }
    
    
    
    
    //////////////////////////////////////////////////////////
    // Mark: Error reporting
    func reportError(message: String) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: SoundManager.Notifications.notificationPlayAlertSound), object: nil)
        let alert = UIAlertController(title: "Oops!", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Got it", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    
    
    
    //////////////////////////////////////////////////////////
    // Mark: Manually created button selectors
    
    // called when a master type (top buttons) is selected
    func onMasterType(sender: UIButton) {
        
        // attempt to convert sender's title to a master type
        guard let titleText = sender.titleLabel?.text,
            let selectedType = EntrantType.MasterType(rawValue: titleText) else {
                return
        }
        
        // only proceed if it is a change from the previous value
        if selectedType != model.activeEntrantType.masterType {
            
            // update the model
            model.activeEntrantType.masterType = selectedType
            
            // create new sub type buttons
            createSubTypeButtons()
        }
    }
    
    // called when a sub type (second row of buttons) is selected
    func onSubType(sender: UIButton) {
        
        // attempt to convert sender's title to a sub type
        guard let titleText = sender.titleLabel?.text,
            let selectedType = EntrantType.SubType(rawValue: titleText) else {
                return
        }
        
        // only proceed if it is a change from the previous value
        if selectedType != model.activeEntrantType.subType {
            
            // update the model
            model.activeEntrantType.subType = selectedType
            
            refreshControlEnablement()
            refreshButtonHighlighting()
            clearOutOldValues()
        }
    }
    
    
    
    
    //////////////////////////////////////////////////////////
    // Mark: Data entry fields handling
    
    // change enablement of fields based on master and sub type combination
    func refreshControlEnablement() {
        model.activeEntrantType.getEnablementPolicy().applyPolicy(to: allLabels)
        model.activeEntrantType.getEnablementPolicy().applyPolicy(to: allFields)
        
        // after the update policy is applied, change the fields' background
        // color - to better indicate disablement
        for field in allFields {
            if field.isEnabled {
               field.backgroundColor = UIColor.white
            } else {
                field.backgroundColor = UIColor.TMRGBA(red: 210, green: 204, blue: 215, alpha: 255)
            }
        }
    }
    
    // clear out any lingering data
    func clearOutOldValues() {
        for field in allFields {
            field.text = ""
        }
    }
    

    
    
    //////////////////////////////////////////////////////////
    // Mark: Master Type and Sub Type Buttons
    
    func refreshButtonHighlighting() {
        
        let currentType = model.activeEntrantType
        
        // try to get the index of the currently selected entrant master type's position
        // in the array of possible values for amster type - used to highlight active master type
        guard let selectedMasterIndex = EntrantType.MasterType.getAllValues().index(of: currentType.masterType) else {
            return
        }
        
        // unhighlight all master type buttons
        entrantButtonColors.applyUnhighlightTo(buttons: masterTypeButtons)
        
        // check that the index  we got from "all values" array can be found in our 
        // buttons array (should correspond exactly), then highlight that specific button
        if masterTypeButtons.indices.contains(selectedMasterIndex) {
            
            // using homegrown ButtonHighlightColors policy manager
            entrantButtonColors.applyHighlightTo(buttons: [masterTypeButtons[selectedMasterIndex]])
        }
        
        // try to get the index of the currently selected entrant sub type from the model
        // unwrap it first
        guard let selectedSubTypeIndex = currentType.masterType.getAllSubTypes().index(of: currentType.subType) else {
            return
        }
        
        // unhighlight all the sub type buttons
        entrantButtonColors.applyUnhighlightTo(buttons: subTypeButtons)
        
        // check that the index  we got from "all values" array can be found in our
        // buttons array (should correspond exactly), then highlight that specific button
        if subTypeButtons.indices.contains(selectedSubTypeIndex) {
            entrantButtonColors.applyHighlightTo(buttons: [subTypeButtons[selectedSubTypeIndex]])
        }
    }
    
    // create a button
    func getButton(asMaster: Bool, title:String) -> UIButton {
        
        let button = UIButton()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(title, for: .normal)
        button.setTitleColor(.white, for: .normal)
        
        let fontSize: CGFloat
        
        if asMaster {
            fontSize = 30
        } else {
            fontSize = 24
        }
        
        button.titleLabel?.font = UIFont(name: "Arial", size: fontSize)
        
        return button
    }
    
    func createMasterTypeButtons() {
        
        // N.B. this happens only done once - when screen initially loads
        
        // fetch all available master types
        let types = EntrantType.MasterType.getAllValues()
        
        // create the new buttons
        for type in types {
            
            let newButton = getButton(asMaster: true, title: type.rawValue)
            newButton.addTarget(self, action: #selector(onMasterType(sender:)), for: .touchUpInside)
            
            // create master type button for this type
            masterTypeButtons.append(newButton)
           
            // add the button to the stack view
            entrantTypeStackView.addArrangedSubview(newButton)
        }
        
        // initially we will make the first master type active
        if let first = types.first {
            model.activeEntrantType.masterType = first
        }
        
        // now create the appropriate sub type buttons
        createSubTypeButtons()
    }
    
    func createSubTypeButtons() {
        
        // N.B. this happens each time master type changes
        
        // clear out old buttons from stack view
        for button in subTypeButtons {
            button.removeFromSuperview()
        }
        
        // clear out old buttons from our button array
        subTypeButtons.removeAll()
        
        // fetch the available sub types for the currently selected entrant type
        let subTypes = model.activeEntrantType.masterType.getAllSubTypes()
        
        // create the new buttons
        for subType in subTypes {
            
            let newButton = getButton(asMaster: false,title: subType.rawValue)
            newButton.addTarget(self, action: #selector(onSubType(sender:)), for: .touchUpInside)
            
            // create sub type button for this subtype
            subTypeButtons.append(newButton)
            
            // add the button to the stack view
            entrantSubTypeStackView.addArrangedSubview(newButton)
        }
        
        // initially we will make the first sub type active
        if let first = subTypes.first {
            model.activeEntrantType.subType = first
        }
        
        // highlight sub type buttons based on 
        refreshButtonHighlighting()
        
        // refresh control enablement
        refreshControlEnablement()
        
        // clear out old data
        clearOutOldValues()
    }
    
    
    
    
    //////////////////////////////////////////////////////////
    // Mark: PassViewControllerDelegate
    
    // when we segue to the pass view controller, set its delegate to us
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let passVC = segue.destination as? PassViewController {
            passVC.delegate = self
        }
    }
    
    // returns the current model's Pass object if available
    func getCurrentPass() -> Pass? {
        return model.currenPass
    }
    
    // clear out current pass object and dismiss pass view controller
    func onDismissPassViewController() {
        model.currenPass = nil
        dismiss(animated: true, completion: nil)
    }
}

