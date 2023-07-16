//
//  GameScene.swift
//  Assignment_2_SwiftApp_00171034
//
//  Created by user212086 on 4/25/23.
//

import SpriteKit
/*
 Class that handles the gameplay
 */
class GameScene: SKScene, SKPhysicsContactDelegate{
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    weak var viewController: UIViewController?
    //enemy & collectable sprites
    let player = SKSpriteNode(imageNamed: "player")
    let algae = SKSpriteNode(imageNamed: "algae.png")
    let amoeba = SKSpriteNode(imageNamed: "amoeba.png")
    let bacteria = SKSpriteNode(imageNamed: "bacteria.png")
    let nematode = SKSpriteNode(imageNamed: "nematode.png")
    let plantcell = SKSpriteNode(imageNamed: "plantcell.png")
    //dial sprites
    let lightLevelDial = SKSpriteNode(imageNamed: "Dial")
    let dialSurround = SKSpriteNode(imageNamed: "DialSurround")
    //boundary sprites
    let leftWall = SKSpriteNode()
    let rightWall = SKSpriteNode()
    let lowerPlayerWall = SKSpriteNode(imageNamed: "hudbg")
    //declaring bitmasks for collisions
    let enemyCategory:UInt32 = 0x1 << 0;
    let wallCategory:UInt32 = 0x1 << 1;
    let playerCategory:UInt32 =  0x1 << 2;
    let playerWallCategory:UInt32 = 0x1 << 3;
    //variable used in game
    var currentScore : Int = 0
    var isDaytime : Bool = true
    
    //label declarations
    var scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
    let timerLabelText : SKLabelNode = SKLabelNode(fontNamed: "Chalkduster")
    let timerLabel : SKLabelNode = SKLabelNode(fontNamed: "Chalkduster")
    let modeLabelText : SKLabelNode = SKLabelNode(fontNamed: "Chalkduster")
    let modeLabel : SKLabelNode = SKLabelNode(fontNamed: "Chalkduster")
    //Timer declaratio
    var time: Int = 60
    {   //didset method monitors changes in this variable and updates the label
        didSet
        {
            if(time >= 10)
            {
                timerLabel.text =  String(time)
            } else{
                timerLabel.text = "0" + String(time)
            }
        }
    }
    
    /*
     Function that is called when the GameScene class is instatiated
     */
    override func didMove(to view: SKView) {
        self.physicsWorld.gravity = CGVector(dx: 0.0, dy: 0.0)
        physicsWorld.contactDelegate = self
        //Add rotation gesture to view
        let rotateGesture = UIRotationGestureRecognizer(target: self, action: #selector(myRotate(_sender:)))
        view.addGestureRecognizer(rotateGesture)
        
        
        createWalls()
        createHud()
        backgroundColor = SKColor.cyan
        
        //set player character position, size, physics body,and bitmask
        player.position = CGPoint(x: size.width/2, y: size.height*0.3)
        player.size = CGSize(width: 50, height: 50)
        player.physicsBody = SKPhysicsBody(rectangleOf: player.frame.size)
        player.physicsBody?.categoryBitMask = playerCategory
        player.physicsBody?.collisionBitMask &= ~enemyCategory  //ignore collision physics with enemy
        player.name = "player"
        addChild(player)
        
        //runs an action that repeats a sequence which calls reduce time every second
        run(SKAction.repeatForever(SKAction.sequence([SKAction.run(reduceTime), SKAction.wait(forDuration: 1)])))
        
    }
    
    /*
     Reduces time by 1, ends game when reaches 0
     */
    func reduceTime(){
        time -= 1
        if(time == 0){
            endGame()
        }
    }
    
    /*
     Function to handle rotation, when performs rotation gesture
     Sets boolean to indicate day or night, this is used to change enemies that appear, also alters background colour
     */
    @objc func myRotate(_sender: UIRotationGestureRecognizer){
        let rotation = _sender.rotation
        let deg = Int(rotation * 180 / .pi)   //Convert rotation data to degrees
        lightLevelDial.zRotation = -rotation //sets rotation of dial to follow rotation gesture
        //conditional statements to test for 180 degree rotation
        if(deg > 180){
            backgroundColor = SKColor.cyan
            isDaytime = true
            modeLabel.text = "Day"
        }
        if(deg < -180){
            backgroundColor = SKColor.gray
            isDaytime = false
            modeLabel.text = "Night"
        }
    }
    
    /*
     Update function called every frame, responsible for adding game objects via addGameObjectFunction
     */
    override func update(_ currentTime: TimeInterval) {
        
        addGameObjects()
    }
    
    /*
     Function called when there has been contact between two game objects, used to adjust score and remove game objects
     */
    func didBegin(_ contact: SKPhysicsContact) {

        if(contact.bodyA.node == player && contact.bodyB.node?.name == "algae"){
            
            updateScore(scoreToAdd: 135)
            contact.bodyB.node?.removeFromParent()
        }
        if(contact.bodyA.node == player && contact.bodyB.node?.name == "amoeba"){
            
            updateScore(scoreToAdd: -100)
            contact.bodyB.node?.removeFromParent()
        }
        if(contact.bodyA.node == player && contact.bodyB.node?.name == "bacteria"){
            
            updateScore(scoreToAdd: 50)
            contact.bodyB.node?.removeFromParent()
        }
        if(contact.bodyA.node == player && contact.bodyB.node?.name == "nematode"){
            
            updateScore(scoreToAdd: -200)
            contact.bodyB.node?.removeFromParent()
        }
        if(contact.bodyA.node == player && contact.bodyB.node?.name == "plantcell"){
            
            updateScore(scoreToAdd: 35)
            contact.bodyB.node?.removeFromParent()
        }
        if(contact.bodyA.node?.name == "wall" && (contact.bodyB.node?.name == "plantcell" || contact.bodyB.node?.name == "algae" || contact.bodyB.node?.name == "amoeba" || contact.bodyB.node?.name == "bacteria" || contact.bodyB.node?.name == "nematode")){
                        contact.bodyB.node?.removeFromParent()
        }
    }
    
    
    /*
     Creates player control by monitoring when the screen is touched, moves player towards touch point
     */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {return}
        let touchLocation = touch.location(in: self)
        if(touchLocation.y > 200) //Sets dead zone for hud, prevents player from entering
        {
            let moveUser = SKAction.move(to: touchLocation, duration: 1) //move player to touch location
            player.run(moveUser)
        }
    }
    
    
    
    /*
     Creates boundary for game area
     */
    func createWalls()
    {
        leftWall.physicsBody = SKPhysicsBody(edgeFrom: CGPoint(x: 0, y: size.height), to: CGPoint(x:0, y:0))
        addChild(leftWall)
                
        rightWall.physicsBody = SKPhysicsBody(edgeFrom: CGPoint(x: size.width, y: size.height), to: CGPoint(x:size.width, y:0))
        addChild(rightWall)
        //lower wall which contains HUD elements
        lowerPlayerWall.position = CGPoint(x: size.width/2, y: size.height*0.1)
        lowerPlayerWall.size = CGSize(width: size.width, height: 200)
        lowerPlayerWall.physicsBody = SKPhysicsBody(rectangleOf: lowerPlayerWall.frame.size)
        lowerPlayerWall.physicsBody?.categoryBitMask = playerWallCategory
        lowerPlayerWall.physicsBody?.collisionBitMask &= ~enemyCategory
        lowerPlayerWall.name = "wall"
        addChild(lowerPlayerWall)
        
        
    }
    /*
     Creates labels and other hud elements such as the dial
     */
    func createHud(){
        timerLabel.horizontalAlignmentMode = .center
        timerLabel.position = CGPoint(x: size.width*0.2, y: size.height*0.1)
        timerLabelText.text = "Time:"
        timerLabelText.horizontalAlignmentMode = .center
        timerLabelText.position = CGPoint(x: size.width*0.2, y: size.height*0.15)
        modeLabel.horizontalAlignmentMode = .center
        modeLabel.position = CGPoint(x: size.width*0.8, y: size.height*0.1)
        modeLabelText.text = "Mode:"
        modeLabelText.horizontalAlignmentMode = .center
        modeLabelText.position = CGPoint(x: size.width*0.8, y: size.height*0.15)
        modeLabel.text = "Day"
        addChild(timerLabelText)
        addChild(timerLabel)
        addChild(modeLabel)
        addChild(modeLabelText)
        
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.text = "Score: " + String(currentScore)
        scoreLabel.horizontalAlignmentMode = .center
        scoreLabel.position = CGPoint(x: size.width/2, y: size.height*0.9)
        addChild(scoreLabel)
        
        lightLevelDial.position = CGPoint(x: size.width/2, y: size.height*0.1)
        lightLevelDial.size = CGSize(width: 70, height: 70)
        dialSurround.position = CGPoint(x: size.width/2, y: size.height*0.1)
        dialSurround.size = CGSize(width: 150, height: 100)
        addChild(lightLevelDial)
        addChild(dialSurround)
    }
    
    /*
     Updates the players score
     @param score to be added
     */
    func updateScore(scoreToAdd : Int){
        currentScore+=scoreToAdd
        scoreLabel.text = "Score: " + String(currentScore)
    }
    
    /*
     Adds enemies/collectables to screen, uses a random number to give a statistical chance a game object may appear
     the isDaytime boolean is used to control types of game objects that can appear, increasing difficulty when false
     */
    func addGameObjects(){
        
        let algae = SKSpriteNode(imageNamed: "algae.png")
        let amoeba = SKSpriteNode(imageNamed: "amoeba.png")
        let bacteria = SKSpriteNode(imageNamed: "bacteria.png")
        let nematode = SKSpriteNode(imageNamed: "nematode.png")
        let plantcell = SKSpriteNode(imageNamed: "plantcell.png")
        algae.name="algae"
        amoeba.name = "amoeba"
        bacteria.name = "bacteria"
        nematode.name = "nematode"
        plantcell.name = "plantcell"
                
        if Int.random(in: 0..<100) == 50, isDaytime{
            createEnemy(enemy: plantcell)
        }
        if Int.random(in: 0..<125) == 50, isDaytime {
            createEnemy(enemy: bacteria)
        }
        if Int.random(in: 0..<75) == 50, !isDaytime{
            createEnemy(enemy: algae)
        }
        if Int.random(in: 0..<150) == 50, isDaytime{
            createEnemy(enemy: amoeba)
        }
        if Int.random(in: 0..<90) == 50, !isDaytime{
            createEnemy(enemy: nematode)
        }
        
    }
    
    /*
     creates a gameObject sprite and adds it to the canvas
     @param type of sprite to be created
     */
    func createEnemy(enemy:SKSpriteNode)
    {
        let randomDX = Int.random(in:-1000..<1000)  //used to set a random angle of travel
        let randomX = Int.random(in: 50..<Int(size.width))  //Sets a random x value for start position
        enemy.position = CGPoint(x: randomX, y: Int(size.height))
        enemy.size = CGSize(width: 50, height: 50)
        enemy.physicsBody = SKPhysicsBody(rectangleOf: enemy.frame.size)
        enemy.physicsBody?.categoryBitMask = enemyCategory
        //prevents collisions from slowing object
        enemy.physicsBody?.restitution = 1.0
        enemy.physicsBody?.friction = 0.0
        enemy.physicsBody?.linearDamping = 0.0
        enemy.physicsBody?.isDynamic=true
        enemy.physicsBody?.contactTestBitMask = wallCategory | playerCategory | playerWallCategory
        addChild(enemy)
        enemy.physicsBody?.applyForce(CGVector(dx:-randomDX,dy:-1000))
    }
    
    
    
    /*
     Ends the game by calling another SKscene
     */
    func endGame()
    {
        
        appDelegate.myModel.setCurrentUserScore(score: currentScore) //Adjusts the score in the model
        
        let transition = SKTransition.fade(withDuration: 1.0)
        let newScene = EndScene(size: self.size)
        newScene.viewController = viewController
        self.view?.presentScene(newScene, transition: transition)
         
    }
}



