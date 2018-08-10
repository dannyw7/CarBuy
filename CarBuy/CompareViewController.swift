//
//  CompareViewController.swift
//  CarBuy
//
//  Created by Robert Tyler Young, Daniel Wold, and Nahom Teshome on 4/28/18.
//  Copyright © 2018 Robert Tyler Young, Daniel Wold, and Nahom Teshome. All rights reserved.
//

import UIKit

class CompareViewController: UIViewController {
    
    @IBOutlet var leftCarImage: UIImageView!
    
    @IBOutlet var rightCarImage: UIImageView!
    
    @IBOutlet var leftCarTitle: UILabel!
    
    @IBOutlet var rightCarTitle: UILabel!
    
    @IBOutlet var leftDealer: UILabel!
    
    @IBOutlet var rightDealer: UILabel!
    
    @IBOutlet var leftAddress: UILabel!
    
    @IBOutlet var rightAddress: UILabel!
    
    @IBOutlet var leftTransmission: UILabel!
    
    @IBOutlet var rightTransmission: UILabel!
    
    @IBOutlet var leftEngine: UILabel!
    
    @IBOutlet var rightEngine: UILabel!
    
    @IBOutlet var leftFuel: UILabel!
    
    @IBOutlet var rightFuel: UILabel!
    
    var firstCar = [String: AnyObject]()
    
    var secondCar = [String: AnyObject]()
    
    @IBOutlet weak var carTitleLabel: UILabel!
    @IBOutlet weak var dealerLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var transmissionLabel: UILabel!
    @IBOutlet weak var fuelEconomyLabel: UILabel!
    @IBOutlet weak var engineLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        carTitleLabel.backgroundColor = UIColor.red
        dealerLabel.backgroundColor = UIColor.red
        addressLabel.backgroundColor = UIColor.red
        transmissionLabel.backgroundColor = UIColor.red
        fuelEconomyLabel.backgroundColor = UIColor.red
        engineLabel.backgroundColor = UIColor.red
        
        
        let media = firstCar["media"] as! [String: [String]]
        if media["photo_links"]!.count > 0 {
            let photo = media["photo_links"]![0]
            let url = URL(string: photo)
            let logoImageData = try? Data(contentsOf: url!)
            
            if let imageData = logoImageData {
                leftCarImage.image = UIImage(data: imageData)
            } else {
                leftCarImage.image = UIImage(named: "vehiclePhotoNotAvailable.jpg")
                
            }
        }else {
            leftCarImage.image = UIImage(named: "vehiclePhotoNotAvailable.jpg")
            
        }
        
        let media2 = secondCar["media"] as! [String: [String]]
        if media2["photo_links"]!.count > 0 {
            let photo = media2["photo_links"]![0]
            let url = URL(string: photo)
            let logoImageData = try? Data(contentsOf: url!)
            
            if let imageData = logoImageData {
                rightCarImage.image = UIImage(data: imageData)
            } else {
                rightCarImage.image = UIImage(named: "vehiclePhotoNotAvailable.jpg")
                
            }
        }else {
            rightCarImage.image = UIImage(named: "vehiclePhotoNotAvailable.jpg")
            
        }
        
        let firstTitle = firstCar["heading"]
        if firstTitle is NSNull{
            leftCarTitle.text = ""
        }
        else{
            if let firstTitle = firstCar["heading"]
            {
                leftCarTitle.text = firstTitle as? String
            }
            else
            {
                leftCarTitle.text = ""
            }
        }
        let secondTitle = secondCar["heading"]
        if secondTitle is NSNull{
            rightCarTitle.text = ""
        }
        else{
            if let secondTitle = secondCar["heading"]
            {
                rightCarTitle.text = secondTitle as? String
            }
            else
            {
                rightCarTitle.text = ""
            }
        }
        let firstDealerDict = firstCar["dealer"] as! [String: AnyObject]
        let firstDealName = firstDealerDict["name"]
        if firstDealName is NSNull{
            leftDealer.text = ""
        }
        else
        {
            if let firstDealName = firstDealerDict["name"]
            {
                leftDealer.text = firstDealName as? String
            }
            else
            {
                leftDealer.text = ""
            }
        }
        
        let street1 = firstDealerDict["street"]
        var newStreet1 = String()
        if street1 is NSNull {
            newStreet1 = "N/A"
        } else {
            if let street1 = firstDealerDict["street"] as! String? {
                newStreet1 = street1
            } else {
                newStreet1 = "N/A"
            }
        }
        let city1 = firstDealerDict["street"]
        var newCity1 = String()
        if city1 is NSNull {
            newCity1 = "N/A"
        } else {
            if let city1 = firstDealerDict["city"] as! String? {
                newCity1 = city1
            } else {
                newCity1 = "N/A"
            }
        }
        let state1 = firstDealerDict["state"]
        var newState1 = String()
        if state1 is NSNull {
            newState1 = "N/A"
        } else {
            if let state1 = firstDealerDict["state"] as! String? {
                newState1 = state1
            } else {
                newState1 = "N/A"
            }
        }
        let fullFirstAddress = newStreet1 + ", " + newCity1 + ", " + newState1
        leftAddress.text = fullFirstAddress
        
        let secondDealerDict = secondCar["dealer"] as! [String: AnyObject]
        let secondDealName = secondDealerDict["name"]
        if secondDealName is NSNull{
            rightDealer.text = ""
        }
        else
        {
            if let secondDealName = secondDealerDict["name"]
            {
                rightDealer.text = secondDealName as? String
            }
            else
            {
                rightDealer.text = ""
            }
        }
        
        
        let street = secondDealerDict["street"]
        var newStreet = String()
        if street is NSNull {
            newStreet = "N/A"
        } else {
            if let street = secondDealerDict["street"] as! String? {
                newStreet = street
            } else {
                newStreet = "N/A"
            }
        }
        let city = secondDealerDict["street"]
        var newCity = String()
        if city is NSNull {
            newCity = "N/A"
        } else {
            if let city = secondDealerDict["city"] as! String? {
                newCity = city
            } else {
                newCity = "N/A"
            }
        }
        let state = secondDealerDict["state"]
        var newState = String()
        if state is NSNull {
            newState = "N/A"
        } else {
            if let state = secondDealerDict["state"] as! String? {
                newState = state
            } else {
                newState = "N/A"
            }
        }
        let fullSecondAddress = newStreet + ", " + newCity + ", " + newState
        rightAddress.text = fullSecondAddress
        
        let firstBuildDict = firstCar["build"] as! [String: AnyObject]
        let firstTransmission = firstBuildDict["transmission"]
        if firstTransmission is NSNull
        {
            leftTransmission.text = "N/A"
        }
        else
        {
            if let firstTransmission = firstBuildDict["transmission"]
            {
                leftTransmission.text = firstTransmission as? String
            }
            else
            {
                leftTransmission.text = "N/A"
            }
        }
        
        let firstEngine = firstBuildDict["engine"]
        if firstEngine is NSNull
        {
            leftEngine.text = "N/A"
        }
        else
        {
            if let firstEngine = firstBuildDict["engine"]
            {
                leftEngine.text = firstEngine as? String
            }
            else
            {
                leftEngine.text = "N/A"
            }
        }
        
        let firstFuel = firstBuildDict["highway_miles"]
        if firstFuel is NSNull
        {
            leftFuel.text = "N/A"
        }
        else
        {
            if let firstFuel = firstBuildDict["highway_miles"]
            {
                leftFuel.text = firstFuel as? String
            }
            else
            {
                leftFuel.text = "N/A"
            }
        }
        
        let secondBuildDict = secondCar["build"] as! [String: AnyObject]
        let secondTransmission = secondBuildDict["transmission"]
        if secondTransmission is NSNull
        {
            rightTransmission.text = "N/A"
        }
        else
        {
            if let secondTransmission = secondBuildDict["transmission"]
            {
                rightTransmission.text = secondTransmission as? String
            }
            else
            {
                rightTransmission.text = "N/A"
            }
        }
        
        let secondEngine = secondBuildDict["engine"]
        if secondEngine is NSNull
        {
            rightEngine.text = "N/A"
        }
        else
        {
            if let secondEngine = secondBuildDict["engine"]
            {
                rightEngine.text = secondEngine as? String
            }
            else
            {
                rightEngine.text = "N/A"
            }
        }
        
        let secondFuel = secondBuildDict["highway_miles"]
        if secondFuel is NSNull
        {
            rightFuel.text = "N/A"
        }
        else
        {
            if let secondFuel = secondBuildDict["highway_miles"]
            {
                rightFuel.text = secondFuel as? String
            }
            else
            {
                rightFuel.text = "N/A"
            }
        }
        
     
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
