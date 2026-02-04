//
//  ViewController.swift
//  Flagler Student
//
//  Created by Jeremy Wang on 1/26/26.
//

import UIKit


class HomeViewController: UIViewController {
    
    //Put your IBOutlets before viewDidLoad
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var majorTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func submitButton(_ sender: UIButton) {
        //Get user inputs (optionals)
        let name = nameTextField.text ?? ""
        let major = majorTextField.text ?? "No Major"
        //Shorter form but a little dangerous
        
        //Forced unwrapping, which could cause errors.
        //let alternativeName = nameTextField.text!
        
        //Enhancements - could validate them?
        
        //Call the alert object and do popup.
        
        let message = "Hello world, \(name)! Thank you for your interest in \(major) major! :)"
        
        let alert = UIAlertController(
            title: "Greetings",
            message: message,
            preferredStyle: .alert)
        
        alert.addAction(
            UIAlertAction(title: "OK", style: .default)
        )
        
        present(alert, animated: true)
    
        
    }
    
}

