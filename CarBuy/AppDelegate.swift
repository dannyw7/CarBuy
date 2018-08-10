//
//  AppDelegate.swift
//  CarBuy
//
//  Created by Robert Tyler Young, Daniel Wold, and Nahom Teshome on 4/28/18.
//  Copyright © 2018 Robert Tyler Young, Daniel Wold, and Nahom Teshome. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var dict_CarName_CarData: NSMutableDictionary = NSMutableDictionary()
    var dict_Dealership_Data:NSMutableDictionary = NSMutableDictionary()
    
    var dict_DealerID_DealerInventory : NSMutableDictionary = NSMutableDictionary()
    
    /*
     Instantiate an object from (or create an instance of) the CLLocationManager class and store the
     object reference (unique ID) of the newly created object into the instance variable called locationManager.
     You can use the created location manager object to retrieve the most recent location of the user.
     */
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        UINavigationBar.appearance().barTintColor = UIColor.black
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
        UITabBar.appearance().barTintColor = UIColor.black
        UITabBar.appearance().tintColor = UIColor.white
        UIApplication.shared.statusBarStyle = .lightContent
        
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentDirectoryPath = paths[0] as String
        
        // Add the plist filename to the document directory path to obtain an absolute path to the plist filename
        let plistFilePathInDocumentDirectory = documentDirectoryPath + "/CompaniesILike.plist"
        
        /*
         NSMutableDictionary manages an *unordered* collection of mutable (modifiable) key-value pairs.
         Instantiate an NSMutableDictionary object and initialize it with the contents of the CompaniesILike.plist file.
         */
        let dictionaryFromFile: NSMutableDictionary? = NSMutableDictionary(contentsOfFile: plistFilePathInDocumentDirectory)
        
        /*
         IF the optional variable dictionaryFromFile has a value, THEN
         CompaniesILike.plist exists in the Document directory and the dictionary is successfully created
         ELSE read CompaniesILike.plist from the application's main bundle.
         */
        if let dictionaryFromFileInDocumentDirectory = dictionaryFromFile {
            
            // CompaniesILike.plist exists in the Document directory
            dict_CarName_CarData = dictionaryFromFileInDocumentDirectory
            
        } else {
            
            // CompaniesILike.plist does not exist in the Document directory; Read it from the main bundle.
            
            // Obtain the file path to the plist file in the mainBundle (project folder)
            let plistFilePathInMainBundle = Bundle.main.path(forResource: "CompaniesILike", ofType: "plist")
            
            // Instantiate an NSMutableDictionary object and initialize it with the contents of the CompaniesILike.plist file.
            let dictionaryFromFileInMainBundle: NSMutableDictionary? = NSMutableDictionary(contentsOfFile: plistFilePathInMainBundle!)
            
            // Store the object reference into the instance variable
            dict_CarName_CarData = dictionaryFromFileInMainBundle!
        }
        
        
        

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
        
        // Define the file path to the CompaniesILike.plist file in the Document directory
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentDirectoryPath = paths[0] as String
        
        // Add the plist filename to the document directory path to obtain an absolute path to the plist filename
        let plistFilePathInDocumentDirectory = documentDirectoryPath + "/CompaniesILike.plist"
        
        // Write the NSMutableDictionary to the CompaniesILike.plist file in the Document directory
        dict_CarName_CarData.write(toFile: plistFilePathInDocumentDirectory, atomically: true)
        
        /*
         The flag "atomically" specifies whether the file should be written atomically or not.
         
         If flag atomically is TRUE, the dictionary is first written to an auxiliary file, and
         then the auxiliary file is renamed to path plistFilePathInDocumentDirectory.
         
         If flag atomically is FALSE, the dictionary is written directly to path plistFilePathInDocumentDirectory.
         This is a bad idea since the file can be corrupted if the system crashes during writing.
         
         The TRUE option guarantees that the file will not be corrupted even if the system crashes during writing.
         */
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

