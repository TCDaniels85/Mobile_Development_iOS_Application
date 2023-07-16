//
//  SplashScreenController.swift
//  Assignment_2_SwiftApp_00171034
//
//  Created by user212086 on 4/21/23.
//

import UIKit

class SplashScreenController : UIViewController {
    var timerCount = 5
    var timer:Timer = Timer()
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBOutlet weak var titleImage: UIImageView!
    
    //Starts a timer to countdown
    override func viewDidLoad() {
        super.viewDidLoad()
        progressBar.transform = CGAffineTransform(scaleX: 1, y: 3)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
        
        let parentView = self.view
        let image = UIImageView(image: UIImage(named:"splashbackground")!)
        image.frame = parentView!.bounds
        parentView!.insertSubview(image, at: 0)
        
        titleImage.image = UIImage(named:"maintext")!
    }
    
    /*
     Function fires every second counting down from 5 to create timed splash screen
     Performs segue to first page once at 0
     */
    @objc func timerCounter(){
        timerCount-=1
        let progress = Float(timerCount)
        progressBar.setProgress(progress, animated: true)   //sets progress bar
        if(timerCount == 0 )
        {
            performSegue(withIdentifier: "StartApp", sender: nil)
            timer.invalidate()//stops timer
            
        }
    }
}
