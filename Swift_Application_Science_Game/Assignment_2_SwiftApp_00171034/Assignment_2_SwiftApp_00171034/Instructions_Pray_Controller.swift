//
//  Instructions_Pray_Controller.swift
//  Assignment_2_SwiftApp_00171034
//
//  Created by user212086 on 4/28/23.
//

import UIKit

class InstructionsPrayController : UIViewController
{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var bactInfo: UILabel!
    @IBOutlet weak var pcellInfo: UILabel!
    @IBOutlet weak var algInfo: UILabel!
    
    @IBOutlet weak var preyTitle: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        appDelegate.myModel.setBackground(parent: self.view)
        //Retrieves text from localised string file
        bactInfo.text = NSLocalizedString( "bactInfo", comment: "")
        pcellInfo .text = NSLocalizedString( "pcellInfo", comment: "")
        algInfo.text = NSLocalizedString( "algaeInfo", comment: "")
        
        if(!appDelegate.myModel.isDarkMode){
            preyTitle.textColor = .black
        }
    }
}
