//
//  PhotoGalleryViewController.swift
//  CarBuy
//
//  Created by Robert Tyler Young, Daniel Wold, and Nahom Teshome on 4/28/18.
//  Copyright © 2018 Robert Tyler Young, Daniel Wold, and Nahom Teshome. All rights reserved.
//

import UIKit

class PhotoGalleryViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UIViewControllerPreviewingDelegate {
    
    
    
    // Instance variables
    @IBOutlet var photosCollectionView: UICollectionView!
    var photosPassed = [String]()
    var photoToPass = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Check if iOS device supports 3D Touch
        if( traitCollection.forceTouchCapability == .available){
            
            registerForPreviewing(with: self, sourceView: photosCollectionView)
            
        }
        

        // Do any additional setup after loading the view.
        
        // Have three cells across a "row"
        let photoSize = UIScreen.main.bounds.width / 3 - 3
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsetsMake(20, 0, 10, 0)
        layout.itemSize = CGSize(width: photoSize, height: photoSize)
        
        layout.minimumInteritemSpacing = 3
        layout.minimumLineSpacing = 3
        
        photosCollectionView.collectionViewLayout = layout
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //----------------------------------------
    // Return Number of of CollectViewCells to be displayed
    //----------------------------------------
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photosPassed.count
    }
    
    //----------------------------------------
    // Prepare and return a collection view cell
    //----------------------------------------
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Image", for: indexPath) as! PhotoCollectionViewCell
        let url = URL(string: photosPassed[indexPath.row])
        let logoImageData = try? Data(contentsOf: url!)
        
        if let imageData = logoImageData {
            cell.carImageView.image = UIImage(data: imageData)
        }
        cell.carImageView.contentMode = UIViewContentMode.scaleAspectFit
        return cell
        
    }
    
    //----------------------------------------
    // CollectionViewCell selected
    //----------------------------------------
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let itemNumber = (indexPath as NSIndexPath).item
        
        // Obtain the photo
        let selectedCar = photosPassed[itemNumber]
        photoToPass = selectedCar
        print(photoToPass)
        performSegue(withIdentifier: "Zoom", sender: self)

    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "Zoom" {
            
            // Obtain the object reference of the destination view controller
            let viewPhotoViewController: ViewPhotoViewController = segue.destination as! ViewPhotoViewController
            
            // Pass the data object to the downstream view controller object
            viewPhotoViewController.photoPassed = photoToPass
            
        }
    }
    
    
    
    /*
     -----------------------------
     MARK: - "Peek" method
     -----------------------------
     */
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        guard let indexPath = photosCollectionView?.indexPathForItem(at: location) else { return nil }
        
        guard let cell = photosCollectionView?.cellForItem(at: indexPath) else { return nil }
        
        guard let viewPhotoVC = storyboard?.instantiateViewController(withIdentifier: "ViewPhotoViewController") as? ViewPhotoViewController else { return nil }
        
        let photo = photosPassed[indexPath.item]
        viewPhotoVC.photoPassed = photo
        viewPhotoVC.preferredContentSize = CGSize(width: 0.0, height: 300)
        
        previewingContext.sourceRect = cell.frame
        
        return viewPhotoVC
    }
    
    /*
     -----------------------------
     MARK: - "Pop" method
     -----------------------------
     */
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        show(viewControllerToCommit, sender: self)
        
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



