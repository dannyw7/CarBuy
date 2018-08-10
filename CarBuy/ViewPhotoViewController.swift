//
//  ViewPhotoViewController.swift
//  CarBuy
//
//  Created by CS3714 on 4/29/18.
//  Copyright © 2018 Robert Tyler Young. All rights reserved.
//

import UIKit

class ViewPhotoViewController: UIViewController, UIGestureRecognizerDelegate {
    // Instance variables
    var photoPassed = String()
    
    var lastScaleFactor = 1.0
    var lastTranslation1 = CGPoint(x: 0.0, y: 0.0)
    
    @IBOutlet var viewPhotoImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //add pan gesture
        let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        gestureRecognizer.delegate = self
        viewPhotoImageView.addGestureRecognizer(gestureRecognizer)
        
        //Enable multiple touch and user interaction for textfield
        viewPhotoImageView.isUserInteractionEnabled = true
        viewPhotoImageView.isMultipleTouchEnabled = true
        
        //add pinch gesture
        let pinchGesture = UIPinchGestureRecognizer(target: self, action:#selector(pinchRecognized(pinch:)))
        pinchGesture.delegate = self
        viewPhotoImageView.addGestureRecognizer(pinchGesture)
        
        //add rotate gesture.
        let rotate = UIRotationGestureRecognizer.init(target: self, action: #selector(handleRotate(recognizer:)))
        rotate.delegate = self
        viewPhotoImageView.addGestureRecognizer(rotate)
        
        
        // Do any additional setup after loading the view.
        let url = URL(string: photoPassed)
        
        let logoImageData = try? Data(contentsOf: url!)
        
        if let imageData = logoImageData {
            viewPhotoImageView.image = UIImage(data: imageData)
        }
    }
    
    /*
     --------------------------
     MARK: Handle Pan Gesteure
     --------------------------
     */
    @objc func handlePan(_ gestureRecognizer: UIPanGestureRecognizer) {
        if gestureRecognizer.state == .began || gestureRecognizer.state == .changed {
            
            let translation = gestureRecognizer.translation(in: self.view)
            // note: 'view' is optional and need to be unwrapped
            gestureRecognizer.view!.center = CGPoint(x: gestureRecognizer.view!.center.x + translation.x, y: gestureRecognizer.view!.center.y + translation.y)
            gestureRecognizer.setTranslation(CGPoint.zero, in: self.view)
        }
        
    }
    
    /*
     --------------------------
     MARK: Handle Pinch Gesteure
     --------------------------
     */
    @objc func pinchRecognized(pinch: UIPinchGestureRecognizer) {
        
        if let view = pinch.view {
            view.transform = view.transform.scaledBy(x: pinch.scale, y: pinch.scale)
            pinch.scale = 1
        }
    }
    
    /*
     --------------------------
     MARK: Handle Rotate Gesteure
     --------------------------
     */
    @objc func handleRotate(recognizer : UIRotationGestureRecognizer) {
        if let view = recognizer.view {
            view.transform = view.transform.rotated(by: recognizer.rotation)
            recognizer.rotation = 0
        }
    }
    
    //MARK:- UIGestureRecognizerDelegate Methods
    @objc func gestureRecognizer(_: UIGestureRecognizer,
                           shouldRecognizeSimultaneouslyWith shouldRecognizeSimultaneouslyWithGestureRecognizer:UIGestureRecognizer) -> Bool {
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    
}
