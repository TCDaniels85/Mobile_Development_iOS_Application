//
//  ViewController.swift
//  Assignment_2_SwiftApp_00171034
//
//  Created by user212086 on 4/21/23.
//

import UIKit

class HighScoresController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
   
    //Returns count for number of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appDelegate.myModel.getHighScores().count
    }

    /*
     Uses the array of high scores to fill each cell
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath as IndexPath) as! MyTableViewCell
        
        var userScores = appDelegate.myModel.getHighScores()
        userScores.sort{$0.getScore() > $1.getScore()} //Sorts high scores into ascending order
        
        cell.position.text = String((indexPath.row)+1)
        cell.cellImage.image=userScores[indexPath.row].getImage()
        cell.userName.text = "Name: " + userScores[indexPath.row].getName()
        cell.userScore.text = "Score: " +  String(userScores[indexPath.row].getScore())
        
        return cell
    }


    let cellID = "myCellID"
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appDelegate.myModel.setBackground(parent: self.view)
        self.navigationItem.hidesBackButton = true  //hides back button
        
        //Add pan gesture to return to previous screen
        let backSwipe = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(backwards(_sender:)))
        backSwipe.edges = .right
        self.view.addGestureRecognizer(backSwipe)
    }

    /*
     Checks that the screen edge pan gesture has finished and then returns to home screen
     */
    @objc func backwards(_sender: UIScreenEdgePanGestureRecognizer) {
        //check gesture ended
        if _sender.state == .ended{
            self.performSegue(withIdentifier: "homeSegue", sender: nil)
        }
        
        
    }
    
}

/*
 Allows a custom view to be created for the table cell.
 */
class MyTableViewCell: UITableViewCell{
    
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var position: UILabel!
    
    @IBOutlet weak var cellImage: UIImageView!
    
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var userScore: UILabel!
    
    
}

