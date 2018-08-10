//
//  DealershipsTableViewController.swift
//  CarBuy
//
//  Created by Robert Tyler Young, Daniel Wold, and Nahom Teshome on 4/28/18.
//  Copyright © 2018 Robert Tyler Young, Daniel Wold, and Nahom Teshome. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class DealershipsTableViewController: UITableViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    
    @IBOutlet var dealersTableView: UITableView!
    var milesEntered: String!
    var dealers = [AnyObject]()
    
    var dealerDataToPass = [String]()
    
    // Used for alternating colors fo tableview rows
    let WHITE = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
   
    let WHITE_SMOKE = UIColor(red: 232.0/255.0, green: 232.0/255.0, blue: 232.0/255.0, alpha: 1.0)
    
    //all the information we want for a specific article will be in this array
    var dealerData = [String]()
    
    // Obtain the object reference to the App Delegate object
    let applicationDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    //array that hold all the keys (dictionaries)
    var dealersKeys = [AnyObject]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // NEED TO BE ABLE TO ACCESS THE USERS LOCATION
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled(){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
            
        }
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if(status == CLAuthorizationStatus.denied){
            showLocationDisabledPopUp()
            
        }
        
        //The user has given us permission to access their location, we can now go find the dealerships closest to them
        if(status == CLAuthorizationStatus.authorizedAlways)
        {
            getJsonData()
        }
        if(status == CLAuthorizationStatus.authorizedWhenInUse)
        {
            getJsonData()
        }
        
        
    }
    
    func showLocationDisabledPopUp(){
        let alertController = UIAlertController(title: "Location Access Disabled", message: "In order to find dealers near you we need your location", preferredStyle: .alert)
        let  cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(cancelAction)
        
        let openAction = UIAlertAction(title: "Open Settings", style: .default) { (action) in
            
            if let url1 = URL(string: UIApplicationOpenSettingsURLString){
                UIApplication.shared.open(url1, options: [:], completionHandler: nil)
            }
        }
        alertController.addAction(openAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    //Gets the Json data and parses/collects the information required
    func getJsonData()
    {
        var id = ""
        var sellerName = ""
        let dealershipURL = ""
        var street = ""
        var city = ""
        var state = ""
        var country = ""
        var zipCode = ""
        var phoneNumber = ""
        var email = ""
        var distance = ""
        var dealershipLongitude = ""
        var dealershipLatitude = ""
        
        /*************** List of Actions we will perform below ***************
         1. Obtain JSON data from the IEX API for the obtained stock symbol.
         2. Extract all of the data items of interest from the JSON data.
         3. Create an array containing all of the company data.
         4. Add the created array under the stock symbol Key to the dictionary
         dict_StockSymbol_CompanyData held by the app delegate object.
         5. Update companyTableView.
         ********************************************************************/
        
        /*
         ------------------------------------------------------------------
         1. Obtain JSON data from the IEX API for the obtained stock symbol
         ------------------------------------------------------------------
         */
        
        // Define the API query URL to obtain company data for a given stock symbol
        
        
        
        //
        let latitude = locationManager.location?.coordinate.latitude
        let longitude = locationManager.location?.coordinate.longitude
        
        let latitudeString = String (describing: latitude!)
        let longitudeString = String(describing: longitude!)
        
        
        
        
        let apiURL = "https://marketcheck-prod.apigee.net/v1/dealers?api_key=ydIs0QyX3ZAbC0T80vZcdgNoPmReI3Bi%20&latitude=" + "\(latitudeString)" + "&longitude=" + "\(longitudeString)" + "&radius=" +  milesEntered + "&rows=50"
        
        
        // Create a URL struct data structure from the API query URL string
        let url = URL(string: apiURL)
        
        /*
         We use the NSData object constructor below to download the JSON data via HTTP in a single thread in this method.
         Downloading large amount of data via HTTP in a single thread would result in poor performance.
         For better performance, NSURLSession should be used.
         */
        
        // Declare jsonData as an optional of type Data
        let jsonData: Data?
        
        do {
            /*
             Try getting the JSON data from the URL and map it into virtual memory, if possible and safe.
             Option mappedIfSafe indicates that the file should be mapped into virtual memory, if possible and safe.
             */
            jsonData = try Data(contentsOf: url!, options: NSData.ReadingOptions.mappedIfSafe)
            
        } catch {
            showAlertMessage(messageHeader: "Can't get JSON Data!", messageBody: "No Data found from url!")
            return
        }
        
        if let jsonDataFromApiUrl = jsonData {
            
            // The JSON data is successfully obtained from the API
            
            do {
                /*
                 JSONSerialization class is used to convert JSON and Foundation objects (e.g., NSDictionary) into each other.
                 JSONSerialization class method jsonObject returns an NSDictionary object from the given JSON data.
                 */
                let jsonDataDictionary = try JSONSerialization.jsonObject(with: jsonDataFromApiUrl, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
                
                //must have access to everything in articles so it is easy to access
                dealers = jsonDataDictionary?.value(forKeyPath: "dealers") as! [AnyObject]
                
                
                
                /*
                 ---------------------------------------------------------------
                 2. Extract all of the data items of interest from the JSON data
                 ---------------------------------------------------------------
                 */
                
                for i in 0..<dealers.count{
                    let specificDealer = dealers[i]
                    
                    
                    
                    
                    
                    
                    //***************************
                    // Obtain Dealer ID
                    //***************************
                    
                    
                    
                    if specificDealer["id"] is NSNull {
                        id = ""
                        
                    } else {
                        if let dealerID = specificDealer["id"] as! String? {
                            id = dealerID
                        } else {
                            id = ""
                        }
                    }
                    
                    
                    //***************************
                    // Obtain Seller Name (Name of Dealership)
                    //***************************
                    
                    
                    
                    if specificDealer["seller_name"] is NSNull {
                        sellerName = ""
                        
                    } else {
                        if let name = specificDealer["seller_name"] as! String? {
                            sellerName = name
                        } else {
                            sellerName = ""
                        }
                    }
                    
                    //***************************
                    // Obtain Dealer Street
                    //***************************
                    
                    
                    
                    if specificDealer["street"] is NSNull {
                        street = ""
                        
                    }
                    else{
                        if let dealersStreet = specificDealer["street"] as! String? {
                            street = dealersStreet
                        } else {
                            street = ""
                        }
                    }
                    
                    
                    
                    
                    //***************************
                    // Obtain Dealer City
                    //***************************
                    
                    
                    
                    if specificDealer["city"] is NSNull {
                        city = ""
                        
                    } else {
                        if let dealerCity = specificDealer["city"] as! String? {
                            city = dealerCity
                        } else {
                            city = ""
                        }
                    }
                    
                    
                    //***************************
                    // Obtain Dealer State
                    //***************************
                    
                    
                    
                    if specificDealer["state"] is NSNull {
                        state = ""
                        
                    } else {
                        if let dealerState = specificDealer["state"] as! String? {
                            state = dealerState
                        } else {
                            state = ""
                        }
                    }
                    
                    
                    
                    //***************************
                    // Obtain Dealer Zip Code
                    //***************************
                    
                    
                    
                    if specificDealer["zip"] is NSNull {
                        zipCode = ""
                        
                    } else {
                        if let dealerZip = specificDealer["zip"] as! String? {
                            zipCode = dealerZip
                        } else {
                            zipCode = ""
                        }
                    }
                    
                    
                    
                    //***************************
                    // Obtain Dealer's Latitude
                    //***************************
                    
                    if specificDealer["latitude"] is NSNull {
                        dealershipLatitude = ""
                        
                    } else {
                        if let dealerLat = specificDealer["latitude"] as! String? {
                            dealershipLatitude = dealerLat
                        } else {
                            dealershipLatitude = ""
                        }
                    }
                    
                    
                    //***************************
                    // Obtain Dealer's Longitude
                    //***************************
                    
                    if specificDealer["longitude"] is NSNull {
                        dealershipLongitude = ""
                        
                    } else {
                        if let dealerLong = specificDealer["longitude"] as! String? {
                            dealershipLongitude = dealerLong
                        } else {
                            dealershipLongitude = ""
                        }
                    }
                    
                    
                    
                    //***************************
                    // Obtain Dealer's Country
                    //***************************
                    
                    
                    
                    if specificDealer["country"] is NSNull {
                        country = ""
                        
                    } else {
                        if let dealerCountry = specificDealer["country"] as! String? {
                            country = dealerCountry
                        } else {
                            country = ""
                        }
                    }
                    
                    //***************************
                    // Obtain Dealer Phone Number
                    //***************************
                    
                    
                    
                    if specificDealer["seller_phone"] is NSNull {
                        phoneNumber = ""
                        
                    } else {
                        if let dealerPhoneNumber = specificDealer["seller_phone"] as! String? {
                            phoneNumber = dealerPhoneNumber
                        } else {
                            phoneNumber = ""
                        }
                    }
                    
                    //***************************
                    // Obtain Dealer Email
                    //***************************
                    
                    
                    
                    if specificDealer["seller_email"] is NSNull {
                        email = ""
                        
                    } else {
                        if let dealerEmail = specificDealer["seller_email"] as! String? {
                            email = dealerEmail
                        } else {
                            email = ""
                        }
                    }
                    
                    //***************************
                    // Obtain Dealer Distance
                    //***************************
                    
                    
                    
                    if specificDealer["distance"] is NSNull {
                        phoneNumber = ""
                        
                    } else {
                        if let dealerDistance = specificDealer["distance"] as! Double? {
                            distance = "\(dealerDistance)"
                        } else {
                            distance = ""
                        }
                        
                    }
                    
                    
                    /*
                     ------------------------------------------------------
                     3. Create an array containing all of the Top News data.
                     ------------------------------------------------------
                     */
                    dealerData = [id, sellerName, dealershipURL, street, city, state, country, zipCode, dealershipLatitude, dealershipLongitude, phoneNumber, email, distance]
                    
                    /*
                     ---------------------------------------------------------------------
                     4. Add the created array under the stock symbol Key to the dictionary
                     dict_TopNewsName_TopNewsData held by the app delegate object.
                     ---------------------------------------------------------------------
                     */
                    
                    applicationDelegate.dict_Dealership_Data.setObject(dealerData, forKey: dealers[i] as! NSCopying)
                    
                    dealersKeys = applicationDelegate.dict_Dealership_Data.allKeys as [AnyObject]
                }
                
                /*
                 --------------------------
                 5. Update tableView
                 --------------------------
                 */
                dealersTableView.reloadData()
                
                
            } catch let error as NSError {
                
                showAlertMessage(messageHeader: "JSON Data", messageBody: "Error in JSON Data Serialization: \(error.localizedDescription)")
                return
            }
            
        } else {
            showAlertMessage(messageHeader: "JSON Data", messageBody: "Unable to obtain the JSON data file!")
        }
        
    }
    
    // Returns the row height of a table cell
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
    // MARK: - Table view data source
    
    // Returns the number of sections
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // Returns the number of rows
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dealers.count
    }
    
    
    
    /*
     -----------------------------
     MARK: - Display Alert Message
     -----------------------------
     */
    func showAlertMessage(messageHeader header: String, messageBody body: String) {
        
        /*
         Create a UIAlertController object; dress it up with title, message, and preferred style;
         and store its object reference into local constant alertController
         */
        let alertController = UIAlertController(title: header, message: body, preferredStyle: UIAlertControllerStyle.alert)
        
        // Create a UIAlertAction object and add it to the alert controller
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        // Present the alert controller
        present(alertController, animated: true, completion: nil)
    }
    
    
    
    //-------------------------------------
    // Prepare and Return a Table View Cell
    //-------------------------------------
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let rowNumber = (indexPath as NSIndexPath).row
        
        let cell =  tableView.dequeueReusableCell(withIdentifier: "DealerCell", for: indexPath) as UITableViewCell
        
        let specificDictionary = dealers[rowNumber]
        
        let dealerDataObtained: AnyObject? = applicationDelegate.dict_Dealership_Data[specificDictionary] as AnyObject
        
        var dealerData = dealerDataObtained as! [String]
        
        cell.textLabel?.text = dealerData[1]
        
        cell.detailTextLabel?.text = dealerData[12] + " mi"
        
        return cell
    }
    
    
    
    //---------------------------
    // Top News (Row) Selected
    //---------------------------
    
    // Tapping a row (Video) displays data about the selected Video
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let rowNumber = (indexPath as NSIndexPath).row
        
        // Obtain the videoID of the selected Video
        let selectedDealer = dealers[rowNumber]
        
        // Obtain the list of data values of the selected Video as AnyObject
        let dealerDataObtained: AnyObject? = applicationDelegate.dict_Dealership_Data[selectedDealer] as AnyObject
        
        // Typecast the AnyObject to Swift array of String objects
        dealerDataToPass = dealerDataObtained! as! [String]
        
        
        
        performSegue(withIdentifier: "selectedDealer", sender: self)
        
        
    }
    
    /*
     Changes colors of the table view cell if need be.
     */
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        /*
         The remainder operator (RowNumber % 2) computes how many multiples of 2 will fit inside RowNumber
         and returns the value, either 0 or 1, that is left over (known as the remainder).
         Remainder 0 implies even-numbered rows; Remainder 1 implies odd-numbered rows.
         */
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = WHITE
            
        } else {
            cell.backgroundColor = WHITE_SMOKE
        }
    }
    
   
    
    /*
     -------------------------
     MARK: - Prepare For Segue
     -------------------------
     */

    // This method is called by the system whenever you invoke the method performSegueWithIdentifier:sender:
    // You never call this method. It is invoked by the system.

    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {

        if segue.identifier == "selectedDealer" {

            // Obtain the object reference of the destination view controller
            let dealerInfoViewController: DealerInfoViewController = segue.destination as! DealerInfoViewController

            // Pass the data object to the downstream view controller object
            dealerInfoViewController.dealerDataPassed = dealerDataToPass
        }
    }



}
