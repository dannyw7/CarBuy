//
//  DealerInfoViewController.swift
//  CarBuy
//
//  Created by Robert Tyler Young, Daniel Wold, and Nahom Teshome on 4/28/18.
//  Copyright © 2018 Robert Tyler Young, Daniel Wold, and Nahom Teshome. All rights reserved.
//

import UIKit
import MapKit


class DealerInfoViewController: UIViewController  {
    
    
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var dealerInventoryLabel: UILabel!
    
    @IBOutlet var dealerAddress: UILabel!
    
    var dealerNameToPass: String!
    
    @IBOutlet var milesAway: UILabel!
    @IBOutlet var getDirectionsButton: UIButton!
    
    
    @IBOutlet var dealerPhoneNumber: UILabel!
    
    @IBOutlet var callDealerButton: UIButton!
    //
    @IBOutlet var dealerMapSegmentedControl: UISegmentedControl!
    
    @IBOutlet var dealerTextEntered: UITextField!
    
    @IBOutlet var showDealerOnMapButton: UIButton!
    
    @IBOutlet var nameOfDealer: UILabel!
    
    var dealerDataPassed = [String]()
    
    var dealerIdToPass: String!
    
    
    @IBOutlet var navTitle: UINavigationItem!
    
    // Instance variables holding the object references of the UI objects created in the Storyboard
    @IBOutlet var mapTypeSegmentedControl: UISegmentedControl!
    
    
    
    // Data to pass to downstream view controller GeocodingMapViewController
    var addressToPass = ""
    var mapTypeToPass: MKMapType?
    var latitudeToPass: Double?
    var longitudeToPass: Double?
    
    
    
    
    
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        
        
        
        addressLabel.backgroundColor = UIColor.red
        dealerInventoryLabel.backgroundColor = UIColor.red
        phoneNumberLabel.backgroundColor = UIColor.red
        
        // Set Standard as the default map type
        mapTypeSegmentedControl.selectedSegmentIndex = 0
        getDirectionsButton.isEnabled = true
        getDirectionsButton.isUserInteractionEnabled = true
        //
        
        nameOfDealer.text = dealerDataPassed[1]
        
        navTitle.title = dealerDataPassed[1]
        let address = dealerDataPassed[3] + " " + dealerDataPassed[4] + " " + dealerDataPassed[5] + " "
            + dealerDataPassed[7]
        
        dealerAddress.text = address
        
        milesAway.text = dealerDataPassed[12] + " Miles Away"
        
        
        dealerPhoneNumber.text = dealerDataPassed[10]
        
        
        // Do any additional setup after loading the view.
    }
    
    /*
     ---------------------------
     MARK: - Show Address on Map
     ---------------------------
     */
    
    // This method is invoked when the user taps the "Show the Address on Map" button
    @IBAction func showAddressOnMap(_ sender: UIButton) {
        
        // print(addressTextField.text!)
        
        //addressTextField.text = dealerDataPassed[1]
        addressToPass = dealerDataPassed[1]
        
        
        
        switch mapTypeSegmentedControl.selectedSegmentIndex {
        case 0:
            mapTypeToPass = MKMapType.standard
        case 1:
            mapTypeToPass = MKMapType.satellite
        case 2:
            mapTypeToPass = MKMapType.hybrid
        default:
            return
        }
        //******************
        // Forward Geocoding
        //******************
        
        // Instantiate a forward geocoder object
        let forwardGeocoder = CLGeocoder()
        
        /*
         Ask the forward geocoder object to
         (a) execute its geocodeAddressString method in a new thread *** asynchronously ***
         (b) determine the geolocation (latitude, longitude) of the given address, and
         (c) give the results to the completion handler function geocoderCompletionHandler running under the main thread.
         */
        forwardGeocoder.geocodeAddressString(addressToPass) { (placemarks, error) in
            self.geocoderCompletionHandler(withPlacemarks: placemarks, error: error)
        }
        
        
    }
    
    
    /*
     ---------------------------------
     MARK: - Process Geocoding Results
     ---------------------------------
     */
    private func geocoderCompletionHandler(withPlacemarks placemarks: [CLPlacemark]?, error: Error?) {
        
        if let errorOccurred = error {
            self.showAlertMessage(messageHeader: "Forward Geocoding Unsuccessful!",
                                  messageBody: "Forward Geocoding of the Given Address Failed: (\(errorOccurred))")
            return
        }
        
        var geolocation: CLLocation?
        
        if let placemarks = placemarks, placemarks.count > 0 {
            geolocation = placemarks.first?.location
        }
        
        if let locationObtained = geolocation {
            print(locationObtained)
            self.latitudeToPass = Double (dealerDataPassed[8])
            self.longitudeToPass = Double (dealerDataPassed[9])
            
        } else {
            self.showAlertMessage(messageHeader: "Location Match Failed!",
                                  messageBody: "Unable to Find a Matching Location!")
            return
        }
        
        performSegue(withIdentifier: "Address", sender: self)
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
    
    
    /*
     -------------------------
     MARK: - Prepare for Segue
     -------------------------
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {

        if segue.identifier == "Address" {

            // Obtain the object reference of the destination (downstream) view controller
            let geocodingMapViewController: GeocodingMapViewController = segue.destination as! GeocodingMapViewController

            // Pass the following data to downstream view controller GeocodingMapViewController
            geocodingMapViewController.addressPassed = addressToPass
            geocodingMapViewController.mapTypePassed = mapTypeToPass
            geocodingMapViewController.latitudePassed = latitudeToPass
            geocodingMapViewController.longitudePassed = longitudeToPass
        }

        if segue.identifier == "View Inventory" {

            let diViewController: DealerInventoryTableViewController = segue.destination as! DealerInventoryTableViewController

            diViewController.dealerIdPassed = dealerIdToPass
            diViewController.dealerNamePassed = dealerNameToPass

        }
   }
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func clickedGetDirectionsButton(_ sender: UIButton) {
        
        
        //must have access to the latitude and longitude of the destination
        let latitude = Double (dealerDataPassed[8])
        let longitude = Double (dealerDataPassed[9])
        
        
        //Distance measurement in meters from an existing location
        //The "existing location" in our case will be the end destination
        let regionDistance: CLLocationDistance = 1000
        
        //Formats the latitude and longitude into a coordinate for our map
        let coordinates = CLLocationCoordinate2DMake(latitude!, longitude!)
        
        //creates a new region from the specified coordinate
        //coordinate will be in the center of the new region
        //Region Distance will be 1000 meters wide and 1000 meters tall
        let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
        
        
        //represents the location on which the map view should be centered.
        let options = [MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center), MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)]
        //The icon you will see at your end destination
        //This essentially tells the user that his or her end destination is at this specific point
        let placemark = MKPlacemark(coordinate: coordinates)
        
        //Gets the point of interest seeked by the user and stores that into the variable mapItem
        let mapItem = MKMapItem(placemark: placemark)
        //Set the name of the point of interest to Dealership name
        mapItem.name = dealerDataPassed[1]
        //launch apple maps and display the map item, which is the point of interest the user is seeking
        mapItem.openInMaps(launchOptions: options)
    }
    
    @IBAction func clickedCallNowButton(_ sender: UIButton) {
        
     
        
        if(dealerDataPassed[10] == "N")
        {
            showAlertMessage(messageHeader: "Can't Find Dealer's Phone Number", messageBody: "Dealer phone number is unavailable")
            return
        }
        dealerDataPassed[10] = dealerDataPassed[10].replacingOccurrences(of: "(", with: "")
        dealerDataPassed[10] = dealerDataPassed[10].replacingOccurrences(of: ")", with: "")
        dealerDataPassed[10] = dealerDataPassed[10].replacingOccurrences(of: " ", with: "")
        dealerDataPassed[10] = dealerDataPassed[10].replacingOccurrences(of: "-", with: "")
        
        
        
        let url: NSURL = NSURL(string: "tel://\(dealerDataPassed[10])")!
        UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
    }
    
    
    
    @IBAction func clickedViewInventory(_ sender: UIButton) {
        
        dealerIdToPass = dealerDataPassed[0]
        dealerNameToPass = dealerDataPassed[1]
        
        performSegue(withIdentifier: "View Inventory", sender: self)
        
    }
    
    
    
    
    
}


