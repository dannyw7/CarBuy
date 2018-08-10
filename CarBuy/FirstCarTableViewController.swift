//
//  FirstCarTableViewController.swift
//  CarBuy
//
//  Created by Robert Tyler Young, Daniel Wold, and Nahom Teshome on 4/28/18.
//  Copyright © 2018 Robert Tyler Young, Daniel Wold, and Nahom Teshome. All rights reserved.
//

import UIKit

class FirstCarTableViewController: UITableViewController {
    
    var locationPassed = [Double]()
    var dataPassed = [String]()
    var carDataToPass = [String: AnyObject]()
    var results = [[String: AnyObject]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = true
        self.navigationItem.title = "\(dataPassed[0]) \(dataPassed[1]) \(dataPassed[2])"
        
        // Define the API query URL to obtain company data for a given stock symbol
        let apiUrl = "https://marketcheck-prod.apigee.net/v1/search?api_key=ydIs0QyX3ZAbC0T80vZcdgNoPmReI3Bi&radius=50&year=\(dataPassed[0])&make=\(dataPassed[1])&model=\(dataPassed[2])&rows=25&latitude=\(locationPassed[1])&longitude=\(locationPassed[0])"
        
        
        // Create a URL struct data structure from the API query URL string
        let url = URL(string: apiUrl)
        
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
            showAlertMessage(messageHeader: "Symbol Unrecognized!", messageBody: "No Company found for the stock symbol!")
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
                
                // Typecast the returned NSDictionary as Dictionary<String, AnyObject>
                let dictionaryOfCompanyJsonData = jsonDataDictionary as! Dictionary<String, AnyObject>
                results = dictionaryOfCompanyJsonData["listings"] as! [[String: AnyObject]]
                let num_found = dictionaryOfCompanyJsonData["num_found"] as! NSNumber
                if (num_found == 0) {
                    showAlertMessage(messageHeader: "No Results Found!", messageBody: "No results were found for \(dataPassed[0]) \(dataPassed[1]) \(dataPassed[2]). Please try again!")
                    return
                }
                
                
            } catch let error as NSError {
                
                showAlertMessage(messageHeader: "JSON Data", messageBody: "Error in JSON Data Serialization: \(error.localizedDescription)")
                return
            }
            
        } else {
            showAlertMessage(messageHeader: "JSON Data", messageBody: "Unable to obtain the JSON data file!")
        }
        
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
     --------------------------------------
     MARK: - Table View Data Source Methods
     --------------------------------------
     */
    
    //----------------------------------------
    // Return Number of Sections in Table View
    //----------------------------------------
    
    // We have only one section in the table view
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //---------------------------------
    // Return Number of Rows in Section
    //---------------------------------
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    // Prepare and return a table view cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let rowNumber = (indexPath as NSIndexPath).row
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Car Listing", for: indexPath)
        
        let carListing = results[rowNumber]
        cell.textLabel!.text = carListing["heading"] as? String
        
        let price = carListing["price"]
        var newPrice = NSNumber()
        if price is NSNull {
            newPrice = 0
        } else {
            if let price = carListing["price"] as! NSNumber? {
                newPrice = price
            } else {
                newPrice = 0
            }
        }
        
        let miles = carListing["miles"]
        var newMiles = NSNumber()
        if miles is NSNull {
            newMiles = 0
        } else {
            if let miles = carListing["miles"] as! NSNumber? {
                newMiles = miles
            } else {
                newMiles = 0
            }
        }
        
        let subtitle = "Price: $\(newPrice) | Miles: \(newMiles) miles"
        cell.detailTextLabel!.text = subtitle
        
        let x = carListing["media"] as! [String: [String]]
        if x["photo_links"]!.count > 0 {
            let y = x["photo_links"]![0]
            let url = URL(string: y)
            let logoImageData = try? Data(contentsOf: url!)
            
            if let imageData = logoImageData {
                cell.imageView!.image = UIImage(data: imageData)
            } else {
                cell.imageView!.image = UIImage(named: "vehiclePhotoNotAvailable.jpg")
                
            }
        }else {
            cell.imageView!.image = UIImage(named: "vehiclePhotoNotAvailable.jpg")
            
        }
        cell.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        
        
        
        
        
        // Configure the cell...
        
        return cell
    }
    
    // Tapping a row
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let rowNumber = (indexPath as NSIndexPath).row
        
        // Obtain the car
        let selectedCar = results[rowNumber]
        
        carDataToPass = selectedCar
        
        performSegue(withIdentifier: "toSecondCarSearch", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "toSecondCarSearch" {
            
            // Obtain the object reference of the destination view controller
            let secondCarViewController: SecondCarViewController = segue.destination as! SecondCarViewController
            
            // Pass the data object to the downstream view controller object
            secondCarViewController.firstCarSearchDataPassed = carDataToPass
            
        }
    }
    
    
    
}
