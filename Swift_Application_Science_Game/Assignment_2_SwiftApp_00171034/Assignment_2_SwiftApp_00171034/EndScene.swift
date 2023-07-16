//
//  EndScene.swift
//  Assignment_2_SwiftApp_00171034
//
//  Created by user212086 on 4/28/23.
//

import SpriteKit

/*
 Ending scene, activated after main game has finished. Creates labels and animates them by moving their position on screen
 */
class EndScene: SKScene
{
    weak var viewController: UIViewController?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let scoreLabel : SKLabelNode = SKLabelNode(fontNamed: "Chalkduster")
    let gameOverLabel : SKLabelNode = SKLabelNode(fontNamed: "Chalkduster")
    let continueLabel : SKLabelNode = SKLabelNode(fontNamed: "Chalkduster")
    
    override public func didMove(to view: SKView) {
        backgroundColor = .orange
        
        createLabels()
        
        let moveScore = SKAction.move(to: CGPoint(x: size.width/2, y: (size.height/2 - 20)), duration: 4)
        let moveGameOver = SKAction.move(to: CGPoint(x: size.width/2, y: (size.height/2 + 20)), duration: 4)
        let addLabel = SKAction.run{self.addChild(self.continueLabel)}
        
        let labelSeq = SKAction.sequence([moveGameOver, addLabel]) //Creates a sequence so the continue label is added after move game over action
        scoreLabel.run(moveScore)
        gameOverLabel.run(labelSeq)
        
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(pinchAction))
        self.view?.addGestureRecognizer(pinchGesture)
    }
    
    /*
     Handles the pinch gesture, when the pinch has finished, the player can submit their high score.
     */
    @objc
    private func pinchAction(pinching: UIPinchGestureRecognizer)
    {
        if(pinching.state == .ended)
        {
            //pauses scene and calls segue
            self.view?.isPaused = true
            viewController?.performSegue(withIdentifier: "endGame", sender: nil)
        }
    }
    
    /*
     Creates labels attributes and text
     */
    private func createLabels()
    {
        continueLabel.horizontalAlignmentMode = .center
        continueLabel.position = CGPoint(x: size.width/2, y: size.height*0.3)
        continueLabel.text = "pinch to continue"
        
        scoreLabel.horizontalAlignmentMode = .center
        scoreLabel.position = CGPoint(x: size.width/2, y: -100)
        scoreLabel.text = "Score: " + String(appDelegate.myModel.getCurrentUserScore())
        addChild(scoreLabel)
        
        gameOverLabel.horizontalAlignmentMode = .center
        gameOverLabel.position = CGPoint(x: size.width/2, y: size.height + 100)
        gameOverLabel.text = "GameOver"
        addChild(gameOverLabel)
    }
    
    
    
}

