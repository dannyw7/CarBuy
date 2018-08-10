//
//  CarWebsiteViewController.swift
//  CarBuy
//
//  Created by Robert Tyler Young, Daniel Wold, and Nahom Teshome on 4/28/18.
//  Copyright © 2018 Robert Tyler Young, Daniel Wold, and Nahom Teshome. All rights reserved.
//

import UIKit
import WebKit
class CarWebsiteViewController: UIViewController, WKUIDelegate{
    
    @IBOutlet var navTitle: UINavigationItem!
    
    @IBOutlet var webView: WKWebView!
    var carURLPassed: String!
    var carNamePassed: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navTitle.title = carNamePassed
        if(carURLPassed != "")
        {
            let myURL = URL(string: carURLPassed)
            let myRequest = URLRequest(url: myURL!)
            webView.load(myRequest)
        }
        else{
            showAlertMessage(messageHeader: "URL Not Provided!", messageBody: "Unable to find website")
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
    
    
    
    //information to load the view
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    
    
    
    
}
