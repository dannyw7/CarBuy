//
//  DetailedViewController.swift
//  CarBuy
//
//  Created by Robert Tyler Young, Daniel Wold, and Nahom Teshome on 4/28/18.
//  Copyright © 2018 Robert Tyler Young, Daniel Wold, and Nahom Teshome. All rights reserved.
//

import UIKit

class DiscoverDetailsViewController: UIViewController {
    
    // Instance variables
    
    @IBOutlet var carPic: UIImageView!
    
    @IBOutlet var bodyType: UILabel!
    
    @IBOutlet var transmissionType: UILabel!
    
    @IBOutlet var fuelType: UILabel!
    
    @IBOutlet weak var bodyTypeHeadingLabel: UILabel!
    @IBOutlet weak var transmissionHeadingLabel: UILabel!
    @IBOutlet weak var fuelTypeHeadingLabel: UILabel!
    
    
    
    var rowLookedAtPassed = String()
    
    /*
     carString[0] = Make
     carString[1] = Model
     carString[2] = Car Body/Style
     carString[3] = Fuel Type
     carString[4] = Transmission
     carString[5] = Car pic
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bodyTypeHeadingLabel.backgroundColor = UIColor.red
        transmissionHeadingLabel.backgroundColor = UIColor.red
        fuelTypeHeadingLabel.backgroundColor = UIColor.red
        
        let carString: [String] = (rowLookedAtPassed as AnyObject).components(separatedBy: "|")
        
        self.navigationItem.title = carString[0] + " " + carString[1]
        
        if (carString[5] == "")
        {
            carPic.image = UIImage(named: "vehiclePhotoNotAvailable.png")
        }
        else
        {
            let imurl = URL(string: carString[5])
            let imagedatar = try? Data(contentsOf: imurl!)
            if let imageData = imagedatar
            {
                carPic.image = UIImage(data: imageData)
            }
            else{
                carPic.image = UIImage(named: "vehiclePhotoNotAvailable.png")
            }
        }
        bodyType.text = "\t" + carString[2]
        transmissionType.text = "\t" + carString[4]
        fuelType.text = "\t" + carString[3]
        
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

