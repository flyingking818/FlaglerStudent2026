//
//  FinancialCalculatorViewController.swift
//  Flagler Student
//
//  Created by Jeremy Wang on 2/16/26.
//

import UIKit

class FinancialCalculatorViewController: UIViewController {

    //=====Main Form IBOutlets=======
    //Inputs
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var tuitionTextField: UITextField!
    @IBOutlet weak var scholarshipTextField: UITextField!
    @IBOutlet weak var gradeLevelTextField: UITextField!
    @IBOutlet weak var honorStudentSwitch: UISwitch!
    //Output
    @IBOutlet weak var messageLabel: UILabel!
    
    //=====Subform IBOutlets====
    
    @IBOutlet weak var loanView: UIView!
    @IBOutlet weak var loanAmountTextField: UITextField!
    @IBOutlet weak var aprTextField: UITextField!
    @IBOutlet weak var yearsTextField: UITextField!
    @IBOutlet weak var pmtMessageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // This is a good place for initializtion, controls initialization, database lookup, default values, etc.
        
        //Use the object-oriented programming techniques, especially the dot notion.
        messageLabel.isHidden = true
        pmtMessageLabel.isHidden = true
        loanView.isHidden = true
        honorStudentSwitch.isOn = false
        
    }
    
    //Main Form Calculation Button/Function
    
    @IBAction func calculateButton(_ sender: UIButton) {
        
        let honorDiscountRate = 0.1
        //Our switch code goes here.
        
        //Grab user inputs
        //Worst prace - force unwrapping, which would generate error if the name is nil.
       //let name = nameTextField.text!
        
        //Still not ideal, coalescing is better, but doesn't do the validatioin
        //let name = nameTextField.text ?? ""
        
        //Acceptable, but not efficient if we have many fields to validate.
        //This could lead to nasty "nested" IFs.
        /*
        if let name = nameTextField.text, !name.isEmpty {
            //If everything is fine, let's proceed...
            print("Hello, \(name)!")
        }else{
            messageLabel.text = "Please enter a valid name"
        }
        */
        //Flip the visibility of the output label
        messageLabel.isHidden=false
        
        //Best pratice - use guard let to do early exit! :)
        guard let name = nameTextField.text, !name.isEmpty else {
            messageLabel.text = "Please enter a valid name!"
            return
        }
        
        guard let tuitionText = tuitionTextField.text, !tuitionText.isEmpty, let tuition = Double(tuitionText) else {
            messageLabel.text = "Please enter a valid tution amount!"
            return
        }
        
        guard let scholarshipText = scholarshipTextField.text, !scholarshipText.isEmpty, let scholarship = Double(scholarshipText) else {
            messageLabel.text = "Please enter a valid scholarship amount!"
            return
        }
        
        guard let gradeLevelText = gradeLevelTextField.text, !gradeLevelText.isEmpty else {
            messageLabel.text = "Please enter a valid grade level!"
            return
        }
        
        //======Processing========
        //let will fail because we need to calculate discounts.
        var balance = tuition - scholarship
        
        //Honor students gets 10% discount for the balance
        if honorStudentSwitch.isOn {
            balance = balance * (1-honorDiscountRate)  //explicit
            //balance *= (1-honorDiscountRate)
        }
        
        //Apply grade-leve discounts
        switch gradeLevelText.lowercased() {
            case "freshman":
                balance*=1.0
            case "sophmore":
                balance*=0.98
            case "junior":
                balance*=0.97
            case "senior":
                balance*=0.95
            default:
                messageLabel.text="Invalid grade level!"
                break
        }
        
        //If the balance is over 10,000, suggest a loan for students to consider.
        let message: String //explicit declaraction
        if balance > 10000 {
            message="\(name), your estimated balance is \(balance.formatted(.currency(code: "USD"))). You quality for a student loan."
        }
        else{
            message="\(name), your estimated balance is \(balance.formatted(.currency(code: "USD")))."
        }
        messageLabel.text=message
    
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
