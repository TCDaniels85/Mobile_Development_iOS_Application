//
//  MyModel.swift
//  Assignment_2_SwiftApp_00171034
//
//  Created by user212086 on 4/21/23.
//

import UIKit

/*
 Model to allow data to persist between views
 */
class MyModel {
    
    var appBackground : UIImage
    let backgroundImage = BackgroundImage(lightImage: UIImage(named:"lightbkground")!, darkImage: UIImage(named:"darkbkground")!)
    var currentUserScore: Int
    var highScores = [UserScore]()
    var isDarkMode = false
    
    init()
    {
        //Sets some default high scores
        highScores.append(UserScore(name: "John", score: 15, image:UIImage(named:"img1")!))
        highScores.append(UserScore(name: "Sue", score: 35, image:UIImage(named:"img2")!))
        highScores.append(UserScore(name: "Bob", score: 1000, image:UIImage(named:"img3")!))
        highScores.append(UserScore(name: "Julie", score: 705, image:UIImage(named:"img4")!))
        highScores.append(UserScore(name: "Dan", score: 425, image:UIImage(named:"img1")!))
        highScores.append(UserScore(name: "Danielle", score: 3165, image:UIImage(named:"img2")!))
        highScores.append(UserScore(name: "Bobby", score: 1075, image:UIImage(named:"img3")!))
        
        
        appBackground = backgroundImage.getLightImage()//set the initial background image
        
        currentUserScore = 0
    }
    
    
    /*
     Add a high score object to the array of high scores
     */
    open func addHighScore(name:String, score:Int, image:UIImage){
        highScores.append(UserScore(name: name, score: score, image: image))
    }
    
    /*
     Returs the array of high scores
     */
    open func getHighScores()->[UserScore]
    {
        return highScores
    }
    
    
    /*
     Sets the appBackgound field to the light image (to simualte a dark mode) appBackground is then used
     to set the background image off the view
     */
    open func setLightMode()
    {
        appBackground = backgroundImage.getLightImage()
        isDarkMode = false
    }
    
    /*
     Sets the appBackgound field to the dark image (to simualte a dark mode) appBackground is then used
     to set the background image off the view
     */
    open func setDarkMode()
    {
        appBackground = backgroundImage.getDarkImage()
        isDarkMode = true
    }
    
    
    /*
     Function sets the current background image displayed on the view
     @param reference to the view currently displayed
     */
    open func setBackground(parent:UIView){
        let image = UIImageView(image: appBackground)
        image.frame = parent.bounds
        parent.insertSubview(image, at: 0)
        
    }
    
    /*
     Set the current user score, available across views
     @Param the score obtained in the current view
     */
    open func setCurrentUserScore(score: Int)
    {
        currentUserScore += score
    }
    
    /*
     Retrieve the currentUserScore
     @return current user score from myModel
     */
    open func getCurrentUserScore() -> Int
    {
        return currentUserScore
    }
    
    /*
     Reset to zero
     */
    open func resetCurrentUserScore()
    {
        currentUserScore = 0
        
    }
    
    
    
}


/*
 Class to create user score objects, these are used to record a users details and high scores.
 */
class UserScore {
    private var name:String
    private var score:Int
    private var image:UIImage
    
    init(name:String, score:Int, image:UIImage)
    {
        self.name=name
        self.score=score
        self.image = image
    }
    
    public func getName()->String
    {
        return name
    }
    
    public func getScore() -> Int
    {
        return score
    }
    
    public func getImage() -> UIImage
    {
        return image
    }
}




/*
 Class to handle the background images being displayed
 */
class BackgroundImage {
    let lightImage:UIImage
    let  darkImage:UIImage
    
    init(lightImage:UIImage, darkImage:UIImage){
        self.lightImage = lightImage
        self.darkImage = darkImage
    }
    
    public func getDarkImage() -> UIImage
    {
        return darkImage
    }
    
    public func getLightImage() -> UIImage{
        return lightImage
    }
}
