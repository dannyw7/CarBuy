//
//  MyFavoritesTableViewController.swift
//  CarBuy
//
//  Created by Robert Tyler Young, Daniel Wold, and Nahom Teshome on 4/28/18.
//  Copyright © 2018 Robert Tyler Young, Daniel Wold, and Nahom Teshome. All rights reserved.
//

import UIKit

class MyFavoritesTableViewController: UITableViewController {
    
    // Instance variables
    
    // Obtain the object reference to the App Delegate object
    let applicationDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var data = [String]()
    
    var webDataToPass = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.clearsSelectionOnViewWillAppear = true
        self.navigationItem.title = "My Favorites"
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        data = applicationDelegate.dict_CarName_CarData.allKeys as! [String]
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
        return data.count
    }
    
    
    //---------------------------------
    // Return Cell
    //---------------------------------
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let rowNumber = (indexPath as NSIndexPath).row
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Favorite", for: indexPath)
        
        let carHeading = data[rowNumber]
        cell.textLabel!.text = carHeading
        
        // Obtain car data
        let dataObtained: AnyObject? = applicationDelegate.dict_CarName_CarData[carHeading] as AnyObject
        
        // Typecast the AnyObject to Swift array of String objects
        var carData = dataObtained! as! [String]
        
        cell.detailTextLabel!.text = carData[2]
        
        let whatever = carData[3]
        let url = URL(string: whatever)
        let logoImageData = try? Data(contentsOf: url!)
        
        if let imageData = logoImageData {
            cell.imageView?.image = UIImage(data: imageData)
        }
        else {
            cell.imageView?.image = UIImage(named: "vehiclePhotoNotAvailable.jpg")
        }
        
        
        // Configure the cell...
        
        return cell
    }
    
    //-------------------------------
    // Allow Editing of Rows (Cities)
    //-------------------------------
    
    // We allow each row (Company) of the table view to be editable, i.e., deletable
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    
    //---------------------
    // Delete Button Tapped
    //---------------------
    
    // This is the method invoked when the user taps the Delete button in the Edit mode
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {   // Handle the Delete action
            
            let rowNumber = (indexPath as NSIndexPath).row
            
            // Obtain the car
            let carHeading = data[rowNumber]
            
            applicationDelegate.dict_CarName_CarData.removeObject(forKey: carHeading)
            data.remove(at: rowNumber)
            self.tableView.reloadData()
        }
    }
    
    // Tapping a row
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let rowNumber = (indexPath as NSIndexPath).row
        
        // Obtain the car
        let carHeading = data[rowNumber]
        
        
        let dataObtained: AnyObject? = applicationDelegate.dict_CarName_CarData[carHeading] as AnyObject
        
        // Typecast the AnyObject to Swift array of String objects
        var carData = dataObtained! as! [String]
        
        webDataToPass = [carHeading, carData[2]]
        
        performSegue(withIdentifier: "Site", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        
        if segue.identifier == "Site" {
            let myFavoritesViewController: MyFavoritesViewController = segue.destination as! MyFavoritesViewController
            myFavoritesViewController.webDataPassed = webDataToPass
            
        }
    }
}
