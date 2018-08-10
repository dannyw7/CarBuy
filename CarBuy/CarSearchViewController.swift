//
//  CarSearchViewController.swift
//  CarBuy
//
//  Created by Robert Tyler Young, Daniel Wold, and Nahom Teshome on 4/28/18.
//  Copyright © 2018 Robert Tyler Young, Daniel Wold, and Nahom Teshome. All rights reserved.
//

import UIKit

import CoreLocation
class CarSearchViewController: UIViewController {
    
    // Instance variables from Storyboard
    @IBOutlet var loadingLabel: UILabel!
    @IBOutlet var carYearTextField: UITextField!
    @IBOutlet var carMakeTextField: UITextField!
    @IBOutlet var carModelTextField: UITextField!
    
    // Instance variables
    var dataToPass = [String]()
    var locationToPass = [Double]()
    var currentLocation = CLLocation()
    var locationManager = CLLocationManager()
    
    /*
     -----------------------------
     Search Button Pressed
     -----------------------------
     */
    @IBAction func searchPressedButton(_ sender: UIButton) {
        
        // Asks user for permission for location
        self.locationManager.requestWhenInUseAuthorization()
        if( CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways){
            currentLocation = locationManager.location!
        }
        
        // Obtain data from text fields
        let carYear = carYearTextField.text!
        let carMake = carMakeTextField.text!
        let carModel = carModelTextField.text!
        
        // Create the data to pass
        dataToPass = [carYear, carMake, carModel]
        locationToPass = [currentLocation.coordinate.longitude, currentLocation.coordinate.latitude]
        
        // Perform segue
        performSegue(withIdentifier: "Search", sender: sender)
        

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     -----------------------------
     MARK: - Background touch
     -----------------------------
     */
    @IBAction func backgroundTouch(_ sender: UIControl) {
        /*
         "This method looks at the current view and its subview hierarchy for the text field that is
         currently the first responder. If it finds one, it asks that text field to resign as first responder.
         If the force parameter is set to true, the text field is never even asked; it is forced to resign." [Apple]
         
         When the Text Field resigns as first responder, the keyboard is automatically removed.
         */
        view.endEditing(true)
    }
    
    
    /*
     -----------------------------
     MARK: - Taps done on Keyboard
     -----------------------------
     */
    @IBAction func keyboardDone(_ sender: UITextField) {
        
        // When the Text Field resigns as first responder, the keyboard is automatically removed.
        sender.resignFirstResponder()
    }
    
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "Search" {
            
            // Obtain the object reference of the destination view controller
            let searchResultsTableViewController: SearchResultsTableViewController = segue.destination as! SearchResultsTableViewController
            
            // Pass the data object to the downstream view controller object
            searchResultsTableViewController.dataPassed = dataToPass
            searchResultsTableViewController.locationPassed = locationToPass
            
        }
    }
    

}

