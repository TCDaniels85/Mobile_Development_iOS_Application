//
//  OpeningPage.swift
//  Assignment_2_SwiftApp_00171034
//
//  Created by user212086 on 4/21/23.
//

import UIKit

class OpeningPage : UIViewController{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    @IBOutlet weak var introTitleLabel: UILabel!
    @IBOutlet weak var IntroImage: UIImageView!
    @IBOutlet weak var introductionLabel: UILabel!
    @IBOutlet weak var settingPopup: UIButton!
    
    @IBOutlet weak var titleLabel: UILabel!
    override func viewDidLoad(){
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true  //hides back button
        appDelegate.myModel.setBackground(parent: self.view) // set background image
        
        settingsPopup()
        //Retrieves text from localised string file
        introductionLabel.text = NSLocalizedString( "introText", comment: "")
        IntroImage.image = UIImage(named:"player")!
        introTitleLabel.text = NSLocalizedString( "introTitle", comment: "")
    }
     
    /*
     Button to control the background to give a dark mode effect for the app
     */
    func settingsPopup()
    {   //Sets each option
        let darkMode = {(action: UIAction) in
            self.view.subviews.first?.removeFromSuperview()
            self.appDelegate.myModel.setDarkMode()
            self.appDelegate.myModel.setBackground(parent: self.view)
        }
        
        let lightMode = {
            (action:UIAction) in
            self.view.subviews.first?.removeFromSuperview()
            self.appDelegate.myModel.setLightMode()
            self.appDelegate.myModel.setBackground(parent: self.view)
           
        }//Sets title, state and handler method
        settingPopup.menu = UIMenu(children:[
            UIAction(title: "Light Mode", state: .on, handler: lightMode),
            UIAction(title:"Dark Mode", handler: darkMode)
        ])
        settingPopup.showsMenuAsPrimaryAction = true
        settingPopup.changesSelectionAsPrimaryAction = true        
    }
    
    
}
