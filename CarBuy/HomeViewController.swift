//
//  HomeViewController.swift
//  CarBuy
//
//  Created by Robert Tyler Young, Daniel Wold, and Nahom Teshome on 4/28/18.
//  Copyright © 2018 Robert Tyler Young, Daniel Wold, and Nahom Teshome. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet var homeSegmentedControl: UISegmentedControl!
    
    // Segmented Control clicked
    @IBAction func homeSegmentClicked(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            performSegue(withIdentifier: "myFavorites", sender: self)
        case 1:
            performSegue(withIdentifier: "discoverCar", sender: self)
        default:
            
            return
        }
        homeSegmentedControl.selectedSegmentIndex = UISegmentedControlNoSegment
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        homeSegmentedControl.isSelected = false
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    
}
