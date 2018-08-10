//
//  DiscoverTableViewController.swift
//  CarBuy
//
//  Created by Robert Tyler Young, Daniel Wold, and Nahom Teshome on 4/28/18.
//  Copyright © 2018 Robert Tyler Young, Daniel Wold, and Nahom Teshome. All rights reserved.
//

import UIKit

class DiscoverTableViewController: UITableViewController {
    
    // Instance variables
    var apiQueryRecieved = ""
    
    let tableViewRowHeight: CGFloat = 80.0
    
    // Alternate table view rows have a background color of MintCream or OldLace for clarity of display
    
    // Define WHITE color
    let WHITE = UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1.0)
    
    // Define WHITE_SMOKE color
    let WHITE_SMOKE = UIColor(red: 232.0/255.0, green: 232.0/255.0, blue: 232.0/255.0, alpha: 1.0)
    
    @IBOutlet var discoverTableViewCell: UITableView!
    
    var discoveredCarsArray = [String]()
    
    var rowLookedAt = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.clearsSelectionOnViewWillAppear = true
        let url = URL(string: apiQueryRecieved)
        let jsonData: Data?
        do {
            jsonData = try Data(contentsOf: url!, options: NSData.ReadingOptions.mappedIfSafe)
        }
        catch let error as NSError
        {
            showAlertMessage(messageHeader: "JSON Data", messageBody: "Error in retrieving JSON data: \(error.localizedDescription)")
            return
        }
        if let jsonDataFromApiUrl = jsonData
        {
            do{
                let jsonDataDictionary = try JSONSerialization.jsonObject(with: jsonDataFromApiUrl, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
                let arrayOfDiscoveredCars = jsonDataDictionary!["listings"] as! NSArray
                
                
                if(arrayOfDiscoveredCars.count == 0)
                {
                    showAlertMessage(messageHeader: "No Results Found", messageBody: "Please select another vehicle body type")
                    return
                }
                
                for i in 0..<arrayOfDiscoveredCars.count
                {
                    let curDict = arrayOfDiscoveredCars[i] as! NSDictionary
                    
                    let curMediaDict = curDict["media"] as! NSDictionary
                    
                    let photoChoice = curMediaDict["photo_links"] as! NSArray
                    
                    let curBuildDict = curDict["build"] as! NSDictionary
                    
                    
                    //photoChoice[0]
                    var carPhoto = ""
                    if photoChoice.count == 0
                    {
                        carPhoto = ""
                    }
                    else
                    {
                        carPhoto = photoChoice[0] as! String
                    }
                    
                    var carMake = ""
                    if curBuildDict["make"] is NSNull
                    {
                        carMake = ""
                    }
                    else
                    {
                        if let curBuild = curBuildDict["make"] as! String?
                        {
                            carMake = curBuild
                        }
                    }
                    
                    var carModel = ""
                    if curBuildDict["model"] is NSNull
                    {
                        carModel = ""
                    }
                    else
                    {
                        if let curBuildModel = curBuildDict["model"] as! String?
                        {
                            carModel = curBuildModel
                        }
                    }
                    
                    var carBody = ""
                    if curBuildDict["body_type"] is NSNull
                    {
                        carBody = ""
                    }
                    else
                    {
                        if let curBuildBody = curBuildDict["body_type"] as! String?
                        {
                            carBody = curBuildBody
                        }
                    }
                    
                    var carFuel = ""
                    if curBuildDict["fuel_type"] is NSNull
                    {
                        carFuel = ""
                    }
                    else
                    {
                        if let curBuildFuel = curBuildDict["fuel_type"] as! String?
                        {
                            carFuel = curBuildFuel
                        }
                    }
                    
                    var carTransmission = ""
                    if curBuildDict["transmission"] is NSNull
                    {
                        carTransmission = ""
                    }
                    else
                    {
                        if let curBuildTran = curBuildDict["transmission"] as! String?
                        {
                            carTransmission = curBuildTran
                        }
                    }
                    
                    let carString = carMake + "|" + carModel + "|" + carBody + "|" + carFuel + "|" + carTransmission + "|" + carPhoto
                    
                    discoveredCarsArray.append(carString)
                    
                    
                }
            }
            catch let error as NSError
            {
                showAlertMessage(messageHeader: "JSON Data", messageBody: "Error in JSON Serialization: \(error.localizedDescription)")
            }
        }
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
     ----------------
     MARK : Number of sections
     ----------------
     */
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    /*
     ----------------
     MARK : Number of Rows
     ----------------
     */
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return discoveredCarsArray.count
    }
    
    //data from array is parsed and set to the cell objects
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let rowNumber: Int = (indexPath as NSIndexPath).row
        
        let cell: DiscoverTableViewCell = tableView.dequeueReusableCell(withIdentifier: "discoverCell") as! DiscoverTableViewCell
        
        let carAt = discoveredCarsArray[rowNumber]
        
        let carString: [String] = (carAt as AnyObject).components(separatedBy: "|")
        
        /*
         carString[0] = Make
         carString[1] = Model
         carString[2] = Car Body/Style
         carString[3] = Fuel Type
         carString[4] = Transmission
         carString[5] = Car pic
         */
        cell.carName.text = carString[0] + " " + carString[1]
        cell.carStyle.text = carString[2]
        
        if (carString[5] == "")
        {
            cell.carImage.image = UIImage(named: "vehiclePhotoNotAvailable.jpg")
        }
        else
        {
            let imurl = URL(string: carString[5])
            let imagedatar = try? Data(contentsOf: imurl!)
            if let imageData = imagedatar
            {
                cell.carImage.image = UIImage(data: imageData)
            }
            else{
                cell.carImage.image = UIImage(named: "vehiclePhotoNotAvailable.jpg")
            }
            
            cell.carImage.contentMode = UIViewContentMode.scaleAspectFit
        }
        
        return cell
    }
    
    
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
    //select row
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Obtain the car
        rowLookedAt = discoveredCarsArray[(indexPath as NSIndexPath).row]
        
        performSegue(withIdentifier: "rowTapped", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        
        if segue.identifier == "rowTapped" {
            let detailedViewController: DiscoverDetailsViewController = segue.destination as! DiscoverDetailsViewController
            detailedViewController.rowLookedAtPassed = rowLookedAt

        }
    }
    
    /*
     -----------------------------------
     MARK: - Table View Delegate Methods
     -----------------------------------
     */
    
    // Asks the table view delegate to return the height of a given row.
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return tableViewRowHeight
    }
    
    /*
     Alternate colors
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
}

