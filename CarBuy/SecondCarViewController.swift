//
//  SecondCarViewController.swift
//  CarBuy
//
//  Created by Robert Tyler Young, Daniel Wold, and Nahom Teshome on 4/28/18.
//  Copyright © 2018 Robert Tyler Young, Daniel Wold, and Nahom Teshome. All rights reserved.
//

import UIKit
import CoreLocation
class SecondCarViewController: UIViewController {
    
    var firstCarSearchDataPassed = [String: AnyObject]()
    
    @IBOutlet var carYearTextField2: UITextField!
    @IBOutlet var carMakeTextField2: UITextField!
    @IBOutlet var carModelTextField2: UITextField!
    var dataToPass = [String]()
    var locationToPass = [Double]()
    
    var currentLocation = CLLocation()
    var locationManager = CLLocationManager()
    
    @IBAction func searchPressedButton2(_ sender: UIButton) {
        // Request user's authorization while the app is being used.
        self.locationManager.requestWhenInUseAuthorization()
        if( CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways){
            currentLocation = locationManager.location!
        }
        
        
        let carYear = carYearTextField2.text!
        let carMake = carMakeTextField2.text!
        let carModel = carModelTextField2.text!
        dataToPass = [carYear, carMake, carModel]
        locationToPass = [currentLocation.coordinate.longitude, currentLocation.coordinate.latitude]
        performSegue(withIdentifier: "searchSecondCar", sender: sender)
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "searchSecondCar" {
            
            // Obtain the object reference of the destination view controller
            let searchSecondCarTableViewController: SearchSecondCarTableViewController = segue.destination as! SearchSecondCarTableViewController
            
            searchSecondCarTableViewController.firstCarSearchDataPassed2 = firstCarSearchDataPassed
            
            searchSecondCarTableViewController.locationPassed = locationToPass
            searchSecondCarTableViewController.dataPassed = dataToPass
            
            
            // Pass the data object to the downstream view controller object
            
            
        }
    }
    
}
