//
//  DealerInventoryTableViewController.swift
//  CarBuy
//
//  Created by Robert Tyler Young, Daniel Wold, and Nahom Teshome on 4/28/18.
//  Copyright © 2018 Robert Tyler Young, Daniel Wold, and Nahom Teshome. All rights reserved.
//

import UIKit

class DealerInventoryTableViewController: UITableViewController {
    
    // Instance variabels
    
    // Obtain the object reference to the App Delegate object
    let applicationDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    // Alternating colors
    let WHITE = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
    
    let WHITE_SMOKE = UIColor(red: 232.0/255.0, green: 232.0/255.0, blue: 232.0/255.0, alpha: 1.0)
    
    var dealerNamePassed: String!
    
    
    @IBOutlet var dealerTableView: UITableView!
    var dealerIdPassed: String!
    
    
    var carURLToPass: String!
    var carNameToPass: String!
    var listings = [AnyObject]()
    
    var imagesToPass = [String]()
    
    var headings = [String]()
    
    var carData = [String]()
    var carIDs = [String]()
    
    // Instance variable to hold the country name selected
    var carNameSelected: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getJsonData()
        
        
    }
    
    
    
    
    
    
    
    
    
    //Gets the Json data and parses/collects the information required
    func getJsonData()
    {
        
        var headingLabel = ""
        var exteriorLabel = ""
        var priceLabel = ""
        var msrpLabel = ""
        var carImageURL = ""
        var carWebsiteUrl = ""
        
        var id = ""
    
        
        
        
        
        let apiURL = "https://marketcheck-prod.apigee.net/v1/dealer/\(dealerIdPassed!)/active/inventory?api_key=ydIs0QyX3ZAbC0T80vZcdgNoPmReI3Bi%20&rows=30"
        
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
                
                listings = jsonDataDictionary?.value(forKeyPath: "listings") as! [AnyObject]
                
                if(listings.count == 0)
                {
                    showAlertMessage(messageHeader: "\(dealerNamePassed!)" + "'s Inventory Not Accessible!", messageBody: "Selected dealer has no inventory to show")
                    return
                }
                
                /*
                 ---------------------------------------------------------------
                 2. Extract all of the data items of interest from the JSON data
                 ---------------------------------------------------------------
                 */
                
                for i in 0..<listings.count{
                    let specificDealer = listings[i]
                    
                    let imageDict = specificDealer["media"] as! NSMutableDictionary
                    
                    let photos = imageDict["photo_links"] as! [String]
                    
                    
                    
                    
                    
                    
                    //***************************
                    // Obtain Car Heading
                    //***************************
                    
                    
                    
                    if specificDealer["heading"] is NSNull {
                        headingLabel = ""
                        
                    } else {
                        if let dealerHeader = specificDealer["heading"] as! String? {
                            headingLabel = dealerHeader
                            headings.append(headingLabel)
                            
                        } else {
                            headingLabel = ""
                        }
                    }
                    
                    
                    //***************************
                    // Obtain Exterior Color
                    //***************************
                    
                    
                    
                    if specificDealer["exterior_color"] is NSNull {
                        exteriorLabel = ""
                        
                    } else {
                        if let exteriorColor = specificDealer["exterior_color"] as! String? {
                            exteriorLabel = exteriorColor
                        } else {
                            headingLabel = ""
                        }
                    }
                    
                    
                    
                    //***************************
                    // Obtain Price
                    //***************************
                   
                    
                    if specificDealer["price"] is NSNull{
                        priceLabel = "Price not Provided"
                    }
                    else{
                        
                        if let x =  specificDealer["price"] as! Int?
                        {
                            //price = String (describing: x)
                            priceLabel = "\(x)"
                        }
                        else{
                            priceLabel = "Price not Provided"
                        }
                    }
                    
                    //***************************
                    // Obtain MSRP
                    //***************************
                    
                    
                    
                    
                    if specificDealer["msrp"] is NSNull{
                        msrpLabel = "MSRP not Provided"
                    }
                    else{
                        
                        if let y = specificDealer["msrp"] as! Int?
                        {
                            msrpLabel = "\(y)"
                        }
                        else{
                            msrpLabel = "MSRP not Provided"
                        }
                    }
                    
                    if (photos.count > 0)
                    {
                        carImageURL = photos[0]
                        imagesToPass = photos
                    }
                    
                    
                    
                    
                    //***************************
                    // Obtain ID of Car
                    //***************************
                    
                    
                    
                    if specificDealer["id"] is NSNull {
                        id = ""
                        
                    } else {
                        if let specificId = specificDealer["id"] as! String? {
                            id = specificId
                        } else {
                            id = ""
                        }
                    }
                    
                    //***************************
                    // Obtain Car Website
                    //***************************
                    
                    
                    
                    if specificDealer["vdp_url"] is NSNull {
                        carWebsiteUrl = ""
                        
                    } else {
                        if let url = specificDealer["vdp_url"] as! String? {
                            carWebsiteUrl = url
                        } else {
                            carWebsiteUrl = ""
                        }
                    }
                    
                    
                    
                    /* ------------------------------------------------------
                     3. Create an array containing all of the Top News data.
                     ------------------------------------------------------
                     */
                    carData = [headingLabel, exteriorLabel, priceLabel, carImageURL, carWebsiteUrl, msrpLabel]
                    
                    /*
                     ---------------------------------------------------------------------
                     4. Add the created array under the stock symbol Key to the dictionary
                     dict_TopNewsName_TopNewsData held by the app delegate object.
                     ---------------------------------------------------------------------
                     */
                    //applicationDelegate.dict_top.setObject(companyData, forKey: stockSymbolEntered as NSCopying)
                    
                    applicationDelegate.dict_DealerID_DealerInventory.setObject(carData, forKey: id as NSCopying)
                    carIDs = applicationDelegate.dict_DealerID_DealerInventory.allKeys as! [String]
                    
                    
                }
                
                /*
                 --------------------------
                 5. Update tableView
                 --------------------------
                 */
                dealerTableView.reloadData()
                
                
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
    
    
    // Returns the row heigh of a table cell
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 118
    }
    
    /*
     -------------------------------------------
     MARK: - UITableViewDelegate Protocol Method
     -------------------------------------------
     */
    
    // Informs the table view delegate that the specified row is selected.
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
        
        let rowNumber = (indexPath as NSIndexPath).row
        
        // Obtain the videoID of the selected Video
        let selectedCarId = carIDs[rowNumber]
        
        // Obtain the list of data values of the selected Video as AnyObject
        let carDataObtained: AnyObject? = applicationDelegate.dict_DealerID_DealerInventory[selectedCarId] as AnyObject
        
        // Typecast the AnyObject to Swift array of String objects
        carData = carDataObtained! as! [String]
        
        carNameToPass = carData[0]
        
        //applicationDelegate.dict_DealerID_DealerInventory.
        carURLToPass = carData[4]
        
        
        
        performSegue(withIdentifier: "selectedCar", sender: self)
        
        
        
        
        
    }
    
    
    
    
    // MARK: - Table view data source
    
    // Return the number of sections
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // Number of rows
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return carIDs.count
        
        
    }
    
    
    
    //-------------------------------------
    // Prepare and Return a Table View Cell
    //-------------------------------------
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        let rowNumber = (indexPath as NSIndexPath).row
        
        let cell =  tableView.dequeueReusableCell(withIdentifier: "Inventory Cell", for: indexPath) as! DealerInventoryTableViewCell
        
        
        
        let specificCarID = carIDs[rowNumber]
        
        
        let carDataObtained: AnyObject?
        
        
        carDataObtained = applicationDelegate.dict_DealerID_DealerInventory[specificCarID] as AnyObject
        
        
        var carData = carDataObtained as! [String]
        
        
        
        cell.carHeadingLabel.text =  carData[0]
        cell.exteriorLabel.text = "Exterior: " + carData[1].lowercased()
        cell.priceLabel.text = "Price: $" + carData[2].lowercased()
        cell.msrpLabel.text = "MSRP: " + carData[5]
        cell.dealerLabel.text = dealerNamePassed
        
        let carImageURL = carData[3]
        
        
        if let url = URL(string: carImageURL)
        {
            do{
                let data = try Data(contentsOf: url)
                cell.carImage.image = UIImage(data: data)
            }catch let err{
                print(" Error : \(err.localizedDescription)")
            }
        }
        
        
        
        
        
        return cell
    }
    
    /*
     Alternates colors of rows
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
     MARK: - Prepare for Segue
     -------------------------
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        
        if segue.identifier == "selectedCar" {
            // Obtain the object reference of the destination (downstream) view controller
            let cwViewController : CarWebsiteViewController = segue.destination as! CarWebsiteViewController
            cwViewController.carURLPassed = carURLToPass
            cwViewController.carNamePassed = carNameToPass
            
            
            
        }
    }
    
    
    
}
