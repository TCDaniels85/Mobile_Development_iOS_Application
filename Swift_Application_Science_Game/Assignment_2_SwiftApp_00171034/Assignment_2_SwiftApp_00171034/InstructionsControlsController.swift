//
//  InstructionsControlsController.swift
//  Assignment_2_SwiftApp_00171034
//
//  Created by user212086 on 4/28/23.
//

import UIKit

class ControlsController : UIViewController
{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var controlsLabel: UILabel!
    
    @IBOutlet weak var controlTitle: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        appDelegate.myModel.setBackground(parent: self.view)
        
        controlsLabel.text = NSLocalizedString( "controlInfo", comment: "")
        if(!appDelegate.myModel.isDarkMode){
            controlTitle.textColor = .black
        }
    }
}
