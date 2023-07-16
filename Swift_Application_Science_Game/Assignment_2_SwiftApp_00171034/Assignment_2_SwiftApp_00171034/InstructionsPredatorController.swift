//
//  InstructionsPredatorController.swift
//  Assignment_2_SwiftApp_00171034
//
//  Created by user212086 on 4/28/23.
//

import UIKit

class PredatorInstructions : UIViewController
{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var nemoInfo: UILabel!
    @IBOutlet weak var ambInfo: UILabel!
    
    @IBOutlet weak var predTitle: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        appDelegate.myModel.setBackground(parent: self.view)
        
        ambInfo.text = NSLocalizedString( "ambInfo", comment: "")
        nemoInfo.text = NSLocalizedString( "nemoInfo", comment: "")
        if(!appDelegate.myModel.isDarkMode){
            predTitle.textColor = .black
        }
    }
}
