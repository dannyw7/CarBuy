//
//  ListingDataViewController.swift
//  CarBuy
//
//  Created by Robert Tyler Young, Daniel Wold, and Nahom Teshome on 4/28/18.
//  Copyright © 2018 Robert Tyler Young, Daniel Wold, and Nahom Teshome. All rights reserved.
//

import UIKit

class ListingDataViewController: UIViewController {
    
    
    // Instance variables from storyboard
    @IBOutlet var carListingImageView: UIImageView!
    @IBOutlet var carTitleLabel: UILabel!
    @IBOutlet var carHeadingLabel: UILabel!
    
    @IBOutlet var dealerTitleLabel: UILabel!
    @IBOutlet var dealerNameLabel: UILabel!
    
    @IBOutlet var locationTitleLabel: UILabel!
    @IBOutlet var locationNameLabel: UILabel!
    
    @IBOutlet var transmissionTitleLabel: UILabel!
    @IBOutlet var transmissionNameLabel: UILabel!
    
    @IBOutlet var engineTitleLabel: UILabel!
    @IBOutlet var engineNameLabel: UILabel!
    
    @IBOutlet var fuelEconomyTitleLabel: UILabel!
    @IBOutlet var fuelEconomyNameLabel: UILabel!
    
    // Add to My Favorites button is pressed
    @IBAction func addToMyFavoritesPressed(_ sender: UIButton) {
        
        // obtain dictionary
        let data = applicationDelegate.dict_CarName_CarData
        
        
        // Create item to add
        let heading = carListingDataPassed["heading"]
        var newHeading = String()
        if heading is NSNull {
            newHeading = "N/A"
        } else {
            if let heading = carListingDataPassed["heading"] as! String? {
                newHeading = heading
            } else {
                newHeading = "N/A"
            }
        }
        
        let dealerData = carListingDataPassed["dealer"] as! [String : AnyObject]
        let dealerName = dealerData["name"]
        var newDealerName = String()
        if dealerName is NSNull {
            newDealerName = "N/A"
        } else {
            if let dealerName = dealerData["name"] as! String? {
                newDealerName = dealerName
            } else {
                newDealerName = "N/A"
            }
        }
        let street = dealerData["street"]
        var newStreet = String()
        if street is NSNull {
            newStreet = "N/A"
        } else {
            if let street = dealerData["street"] as! String? {
                newStreet = street
            } else {
                newStreet = "N/A"
            }
        }
        let city = dealerData["street"]
        var newCity = String()
        if city is NSNull {
            newCity = "N/A"
        } else {
            if let city = dealerData["city"] as! String? {
                newCity = city
            } else {
                newCity = "N/A"
            }
        }
        let state = dealerData["state"]
        var newState = String()
        if state is NSNull {
            newState = "N/A"
        } else {
            if let state = dealerData["state"] as! String? {
                newState = state
            } else {
                newState = "N/A"
            }
        }//vdp_url
        let listingURL = carListingDataPassed["vdp_url"]
        var newListingURL = String()
        if listingURL is NSNull {
            newListingURL = "N/A"
        } else {
            if let listingURL = carListingDataPassed["vdp_url"] as! String? {
                newListingURL = listingURL
            } else {
                newListingURL = "N/A"
            }
        }
        
        let x = carListingDataPassed["media"] as! [String: [String]]
        var imageString = String()
        if x["photo_links"]!.count > 0 {
            let y = x["photo_links"]![0]
            let url = URL(string: y)
            let logoImageData = try? Data(contentsOf: url!)
            
            if let imageData = logoImageData {
                imageString = y
                print(imageData)
            }
            else {
                imageString = "vehiclePhotoNotAvailable.jpg"
            }
        }
        else {
            imageString = "vehiclePhotoNotAvailable.jpg"
        }
        
        let location = "\(newStreet), \(newCity), \(newState)"
        let value = [newDealerName, location, newListingURL, imageString]
        
        // Add or modify object to dictionary
        data.setObject(value, forKey: newHeading as NSCopying)
    }
    
    // Obtain the object reference to the App Delegate object
    let applicationDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var carListingDataPassed = [String: AnyObject]()
    
    // Number of images in the slide show
    var numberOfImages = 0
    var listPhotos = [String]()
    
    var previousImageNumber: Int = 0
    
    // A timer that invokes a method after a certain time interval has elapsed
    var timer = Timer()
    
    override func viewDidLoad() {

        // Do any additional setup after loading the view.
        let media = carListingDataPassed["media"] as! [String: [String]]
        if media["photo_links"]!.count > 0 {
            let photoUrl = media["photo_links"]![0]
            let url = URL(string: photoUrl)
            let logoImageData = try? Data(contentsOf: url!)
            
            if let imageData = logoImageData {
                carListingImageView.image = UIImage(data: imageData)
            }
            else {
                carListingImageView.image = UIImage(named: "vehiclePhotoNotAvailable.jpg")
            }
        }
        else {
            carListingImageView.image = UIImage(named: "vehiclePhotoNotAvailable.jpg")
        }
        carListingImageView.contentMode = UIViewContentMode.scaleAspectFit
        carListingImageView.backgroundColor = UIColor.black
        
        carTitleLabel.backgroundColor = UIColor.red
        dealerTitleLabel.backgroundColor = UIColor.red
        locationTitleLabel.backgroundColor = UIColor.red
        transmissionTitleLabel.backgroundColor = UIColor.red
        engineTitleLabel.backgroundColor = UIColor.red
        fuelEconomyTitleLabel.backgroundColor = UIColor.red
        
        let heading = carListingDataPassed["heading"]
        var newHeading = String()
        if heading is NSNull {
            newHeading = "N/A"
        } else {
            if let heading = carListingDataPassed["heading"] as! String? {
                newHeading = heading
            } else {
                newHeading = "N/A"
            }
        }
        carHeadingLabel.text = "\t\(newHeading)"
        
        let dealerData = carListingDataPassed["dealer"] as! [String : AnyObject]
        let dealerName = dealerData["name"]
        var newDealerName = String()
        if dealerName is NSNull {
            newDealerName = "N/A"
        } else {
            if let dealerName = dealerData["name"] as! String? {
                newDealerName = dealerName
            } else {
                newDealerName = "N/A"
            }
        }
        let street = dealerData["street"]
        var newStreet = String()
        if street is NSNull {
            newStreet = "N/A"
        } else {
            if let street = dealerData["street"] as! String? {
                newStreet = street
            } else {
                newStreet = "N/A"
            }
        }
        let city = dealerData["street"]
        var newCity = String()
        if city is NSNull {
            newCity = "N/A"
        } else {
            if let city = dealerData["city"] as! String? {
                newCity = city
            } else {
                newCity = "N/A"
            }
        }
        let state = dealerData["state"]
        var newState = String()
        if state is NSNull {
            newState = "N/A"
        } else {
            if let state = dealerData["state"] as! String? {
                newState = state
            } else {
                newState = "N/A"
            }
        }
        let location = "\(newStreet), \(newCity), \(newState)"
        dealerNameLabel.text = "\t\((newDealerName))"
        locationNameLabel.text = "\t\(location)"
        
        let carData = carListingDataPassed["build"] as! [String: AnyObject]
        let transmission = carData["transmission"]
        var newTransmission = String()
        if transmission is NSNull {
            newTransmission = "N/A"
            print("yeah")
        } else {
            if let transmission = carData["transmission"] as! String? {
                newTransmission = transmission
            } else {
                newTransmission = "N/A"
            }
        }
        transmissionNameLabel.text = "\t\(newTransmission)"
        
        let engine = carData["engine"]
        var newEngine = String()
        if engine is NSNull {
            newEngine = "N/A"
        } else {
            if let engine = carData["engine"] as! String? {
                newEngine = engine
            } else {
                newEngine = "N/A"
            }
        }
        engineNameLabel.text = "\t\(newEngine)"
        
        let city_mpg = carData["city_miles"]
        var newCityMpg = String()
        if city_mpg is NSNull {
            newCityMpg = "N/A"
        } else {
            if let city_mpg = carData["city_miles"] as! String? {
                newCityMpg = city_mpg
            } else {
                newCityMpg = "N/A"
            }
        }
        let hwy_mpg = carData["highway_miles"]
        var newHwyMPG = String()
        if hwy_mpg is NSNull {
            newHwyMPG = "N/A"
        } else {
            if let hwy_mpg = carData["highway_miles"] as! String? {
                newHwyMPG = hwy_mpg
            } else {
                newHwyMPG = "N/A"
            }
        }
        let fuelEconomy = "\t\(newCityMpg), \(newHwyMPG)"
        fuelEconomyNameLabel.text = fuelEconomy
        // Set up image gallery
        
        // Obtain list of images from car listing
        listPhotos = media["photo_links"]!
        numberOfImages = listPhotos.count
        if listPhotos.count == 0 {
            listPhotos = ["vehiclePhotoNotAvailable.jpg"]
        }
        previousImageNumber = 1
        
        startTimer()
        
        // Gesture stuff
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(ListingDataViewController.handleSingleTap(_:)))
        singleTap.numberOfTapsRequired = 1
        carListingImageView.addGestureRecognizer(singleTap)
    }
    
    /*
     -------------------------------
     MARK: - Creation of a New Timer
     -------------------------------
     */
    func startTimer() {
        /*
         Schedule a timer to invoke the changeImage() method given below
         after 3 seconds in a loop that repeats itself until it is stopped.
         */
        timer = Timer.scheduledTimer(timeInterval: 3,
                                     target: self,
                                     selector: (#selector(ListingDataViewController.changeImage)),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    /*
     ----------------------------------
     MARK: - Change Image in the Slider
     ----------------------------------
     */
    @objc func changeImage() {
        if listPhotos[0] != "vehiclePhotoNotAvailable.jpg" {
            if previousImageNumber == numberOfImages {
                
                // End of list is reached
                
                // Make initializations to start the slide show again with image 1
                previousImageNumber = 1
                let y = listPhotos[previousImageNumber - 1]
                let url = URL(string: y)
                let logoImageData = try? Data(contentsOf: url!)
                
                if let imageData = logoImageData {
                    carListingImageView.image = UIImage(data: imageData)
                }
                
            } else {
                
                // Set the previousImageNumber to be the next image number by incrementing by 1
                previousImageNumber += 1
                
                let y = listPhotos[previousImageNumber - 1]
                let url = URL(string: y)
                let logoImageData = try? Data(contentsOf: url!)
                
                if let imageData = logoImageData {
                    carListingImageView.image = UIImage(data: imageData)
                }
                
                
            }
        }
    }
    
    /*
     ----------------------------
     MARK: - Tap Handling Methods
     ----------------------------
     */
    // This method is invoked when single tap gesture is applied
    @objc func handleSingleTap(_ gestureRecognizer: UIGestureRecognizer) {
        if listPhotos[0] != "vehiclePhotoNotAvailable.jpg" {
            print(listPhotos)
            performSegue(withIdentifier: "Images", sender: self)
        }
        else {
            showAlertMessage(messageHeader: "No Images Available!", messageBody: "The listing does not have any images available.")
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "Images" {
            
            // Obtain the object reference of the destination view controller
            let photoGalleryViewController: PhotoGalleryViewController = segue.destination as! PhotoGalleryViewController
            
            // Pass the data object to the downstream view controller object
            photoGalleryViewController.photosPassed = listPhotos
            
        }
    }

    

}
