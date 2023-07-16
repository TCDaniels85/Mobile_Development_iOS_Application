//
//  GameViewController.swift
//  Assignment_2_SwiftApp_00171034
//
//  Created by user212086 on 4/25/23.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController
{
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appDelegate.myModel.resetCurrentUserScore() //resets score back to zero
        self.navigationItem.hidesBackButton = true// hide back button
        let scene = GameScene(size: view.bounds.size)
        let skView = view as! SKView
        scene.scaleMode = .resizeFill
        scene.viewController = self  //create a pointer to the viewController so segue can be performed from the game scene       
        skView.presentScene(scene)
        
    }
    
    
}
