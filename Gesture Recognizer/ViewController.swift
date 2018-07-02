//
//  ViewController.swift
//  Gesture Recognizer
//
//  Created by Lilly Tong on 2018-07-02.
//  Copyright © 2018 Lilly Tong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var fileImageView: UIImageView!
    @IBOutlet weak var trashImageView: UIImageView!
    
    var fileViewOrigin: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //1. enable user interaction
        fileImageView.isUserInteractionEnabled = true //SUPER IMPORTANT, ELSE NOT DRAGGABLE!
        fileViewOrigin = fileImageView.frame.origin //record this value so we can restore position

        //2. add pan gesture recognizer
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan(sender:)))
        fileImageView.addGestureRecognizer(pan)
        
        //3. bring fileView to front
        view.bringSubview(toFront: fileImageView)
    }


    @objc func handlePan(sender: UIPanGestureRecognizer){
        let fileView = sender.view!
        let translation = sender.translation(in: view) //our overall view
        
        switch sender.state{
        case .changed: //file moves with gesture
            fileView.center = CGPoint(x: fileView.center.x + translation.x, y: fileView.center.y + translation.y)
            sender.setTranslation(CGPoint.zero, in: view)
        case .ended:
            if fileView.frame.intersects(trashImageView.frame){
                UIView.animate(withDuration: 0.3) {
                    self.fileImageView.alpha = 0.0 //fade it away
                }
            } else { //bring fileview back to origin
                UIView.animate(withDuration: 0.3) {
                    self.fileImageView.frame.origin = self.fileViewOrigin
                }
            }
        default:
            break
        }
    }
}

