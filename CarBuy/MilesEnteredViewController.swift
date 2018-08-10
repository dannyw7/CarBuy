//
//  MilesEnteredViewController.swift
//  CarBuy
//
//  Created by Robert Tyler Young, Daniel Wold, and Nahom Teshome on 4/28/18.
//  Copyright © 2018 Robert Tyler Young, Daniel Wold, and Nahom Teshome. All rights reserved.
//

import UIKit

class MilesEnteredViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet var milesEnteredTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        milesEnteredTextField.delegate = self
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Background touch
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    /**
     * Called When the Done Key is pressed
     */
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder();
        if (milesEnteredTextField.hasText) {
            performSegue(withIdentifier: "perform search", sender: self)
        }
        return true;
    }
    
    //After the user taps the Done button, this method takes them to the table view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        if segue.identifier == "perform search" {
            
            let dealershipsTableViewController: DealershipsTableViewController = segue.destination as! DealershipsTableViewController
            
            dealershipsTableViewController.milesEntered = milesEnteredTextField.text
            milesEnteredTextField.text = ""
        }
    }
    
    @IBAction func backgroundTouch(_ sender: UIControl) {
        /*
         "This method looks at the current view and its subview hierarchy for the text field that is
         currently the first responder. If it finds one, it asks that text field to resign as first responder.
         If the force parameter is set to true, the text field is never even asked; it is forced to resign." [Apple]
         
         When the Text Field resigns as first responder, the keyboard is automatically removed.
         */
        view.endEditing(true)
    }
    //When the user selects the Done button from the keyboard
    @IBAction func keyboardDone(_ sender: UITextField) {
        
        // When the Text Field resigns as first responder, the keyboard is automatically removed.
        sender.resignFirstResponder()
    }
    
}
