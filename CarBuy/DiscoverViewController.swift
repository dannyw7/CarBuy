//
//  DiscoverDetailsViewController.swift
//  CarBuy
//
//  Created by Robert Tyler Young, Daniel Wold, and Nahom Teshome on 4/28/18.
//  Copyright © 2018 Robert Tyler Young, Daniel Wold, and Nahom Teshome. All rights reserved.
//

import UIKit
import CoreLocation
class DiscoverViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource  {
    
    
    
    // Instance vavriables
    @IBOutlet var carType: UISegmentedControl!
    
    @IBOutlet var pickerView: UIPickerView!
    
    var apiQuery = ""
    
    let apiKey = "ydIs0QyX3ZAbC0T80vZcdgNoPmReI3Bi"
    
    
    var bodyTypes = ["SUV","Convertible", "Coupe", "Sedan", "Pickup", "Hatchback", "Wagon", "Crossover"]
    
    var currentLocation = CLLocation()
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Request user's authorization while the app is being used.
        self.locationManager.requestWhenInUseAuthorization()
        if( CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways){
            currentLocation = locationManager.location!
        }
        
        // Sort list alphabetically
        bodyTypes.sort {$0 < $1}
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Display middle option in picker
    override func viewWillAppear(_ animated: Bool) {
        
        // Obtain the number of the row in the middle of the university names list
        let numberOfRowToShow = Int(bodyTypes.count / 2)
        
        // Show the picker view of the university names from the middle
        pickerView.selectRow(numberOfRowToShow, inComponent: 0, animated: false)
    }
    
    
    
    
    // Discover button clicked
    @IBAction func discoverClicked(_ sender: UIButton) {
        
        var carTypeSelected = ""
        
        switch carType.selectedSegmentIndex
        {
        case 0:
            carTypeSelected = "new"
        case 1:
            carTypeSelected = "used"
        case 2:
            carTypeSelected = "certified"
        default:
            return
            
        }
        
        let rowPicked = pickerView.selectedRow(inComponent: 0)
        
        let bodyTypeForApi = bodyTypes[rowPicked]
        
        apiQuery = "https://marketcheck-prod.apigee.net/v1/search?api_key=\(apiKey)&latitude=\(currentLocation.coordinate.latitude)&longitude=\(currentLocation.coordinate.longitude)&radius=50&car_type=\(carTypeSelected)&body_type=\(bodyTypeForApi)&rows=25"
        print(apiQuery)
        performSegue(withIdentifier: "discoverTable", sender: self)
        
    }
    
    /*
     -----------------------------------------------
     MARK: - UIPickerViewDataSource Protocol Methods
     -----------------------------------------------
     */
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return bodyTypes.count
    }
    
    /*
     --------------------------------------------
     MARK: - UIPickerViewDelegate Protocol Method
     --------------------------------------------
     */
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return bodyTypes[row]
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "discoverTable" {

            // Obtain the object reference of the destination view controller
            let discoverTableViewController: DiscoverTableViewController = segue.destination as! DiscoverTableViewController

            // Pass the data object to the destination view controller
            discoverTableViewController.apiQueryRecieved = apiQuery
        }
    }
    
}

