import SpriteKit
import SwiftUI

class GameScene: SKScene, SKPhysicsContactDelegate {
  
    weak var sceneController: SceneController?
    weak var vm: ViewModel?
    
    private var background: SKSpriteNode!
    var pauseButton: SKSpriteNode!
    
    var upperRing: SKShapeNode!
    var lowerRing: SKShapeNode!
    var ball: SKShapeNode!
    var finish: SKShapeNode!
    
    var ballJumpCount = 0
    var maxJumps = 2
    var gameOver = false
    var ballVelocity: CGFloat = 0.0
    
    // Параметры для полуколец
    let radius: CGFloat = 100
    let startAngleUpper: CGFloat = .pi * 0.7 // Вырез вверху для верхнего кольца
    let endAngleUpper: CGFloat = .pi * 2.3
    let startAngleLower: CGFloat = .pi * 1.7 // Вырез снизу для нижнего кольца
    let endAngleLower: CGFloat = .pi * 1.3
    
    var durationRings: CGFloat = 7.0
    
    
    // Категории для физических тел
    let ballCategory: UInt32 = 0x1 << 0      // Мячик
    let toothCategory: UInt32 = 0x1 << 1     // Зубчики
    let finishCategory: UInt32 = 0x1 << 2    // Финиш
    let innerContourCategory: UInt32 = 0x1 << 3 // Внутренний контур
    let outerContourCategory: UInt32 = 0x1 << 4 // Внешний контур
    
    
    //frames
    var pauseFrame: SKSpriteNode!
    var gameOverFrame: SKSpriteNode!
    var winFrame: SKSpriteNode!
    
    
    var currentLevel = 0
    let totalLevels = 16
    
//    var onDismiss: (() -> Void)?
    
    //MARK: DID MOVE
    override func didMove(to view: SKView) {
        backgroundColor = .clear
        physicsWorld.contactDelegate = self // Set the contact delegate
        
        setupBackground()
        setupPauseButton()
        createUpperRing()
        createLowerRing()
        createBall()
        createFinish()
        createPauseFrame()
        createGameOverFrame()
        createWinFrame()
        
        
        if let sceneController = sceneController {
            let level = sceneController.levels[currentLevel]
            setupTeeth(level: level)
        }

     
        


    }
    
    
    func setupTeeth(level: LevelHightModel) {
    
        addTeeth(to: upperRing,
                 numberOfTeeth: level.upperRingTeethCount,
                 toothSize: level.toothSize,
                 radius: level.radius,
                 angleOffset: level.leftAngleOffset,
                 tightness: level.leftTightness,
                 radiusAdjustment: level.leftRadiusAdjustment,
                toothSizeHeight: level.leftToothSizeHeight
        )

        
        addTeeth(to: lowerRing,
                 numberOfTeeth: level.lowerRingTeethCount,
                 toothSize: level.toothSize,
                 radius: level.radius,
                 angleOffset: level.rightAngleOffset,
                 tightness: level.rightTightness,
                 radiusAdjustment: level.rightRadiusAdjustment,
                 toothSizeHeight: level.rightToothSizeHeight
        
        )
    }
    
    
    //MARK: Pause frame
    
    private func createPauseFrame() {
        pauseFrame = SKSpriteNode(imageNamed: "frameForAction")
        pauseFrame.position = CGPoint(x: size.width / 2, y: size.height / 2)
        pauseFrame.size = CGSize(width: 240, height: 248)
        pauseFrame.zPosition = 1
        
        let titleLabel = SKLabelNode(text: "Pause")
        titleLabel.fontName = "CherryBombOne-Regular"
        titleLabel.fontSize = 32
        titleLabel.fontColor = .white
        titleLabel.position = CGPoint(x: 0, y: 60)
        
        let homeButton = createButton(named: "homeButton", size: CGSize(width: 72, height: 72), position: CGPoint(x: -40, y: -10), name: "home_button")
        let updateButton = createButton(named: "updateButton", size: CGSize(width: 72, height: 72), position: CGPoint(x: 40, y: -10), name: "update_button")
        let closeButton = createButton(named: "close", size: CGSize(width: 32, height: 32), position: CGPoint(x: 0, y: -90), name: "close_button")
        pauseFrame.isHidden = true
        addChild(pauseFrame)
        pauseFrame.addChild(closeButton)
        pauseFrame.addChild(homeButton)
        pauseFrame.addChild(updateButton)
        pauseFrame.addChild(titleLabel)
    }
    
    //MARK: Game Over frame
    
    private func createGameOverFrame() {
        gameOverFrame = SKSpriteNode(imageNamed: "frameForAction")
        gameOverFrame.position = CGPoint(x: size.width / 2, y: size.height / 2)
        gameOverFrame.size = CGSize(width: 240, height: 192)
        gameOverFrame.zPosition = 1
        
        let titleLabel = SKLabelNode(text: "Game Over")
        titleLabel.fontName = "CherryBombOne-Regular"
        titleLabel.fontSize = 32
        titleLabel.fontColor = .white
        titleLabel.position = CGPoint(x: 0, y: 45)
        
        let homeButton = createButton(named: "homeButton", size: CGSize(width: 72, height: 72), position: CGPoint(x: -40, y: -10), name: "home_button")
        let updateButton = createButton(named: "updateButton", size: CGSize(width: 72, height: 72), position: CGPoint(x: 40, y: -10), name: "update_button")
        
        gameOverFrame.isHidden = true
        addChild(gameOverFrame)
        gameOverFrame.addChild(homeButton)
        gameOverFrame.addChild(updateButton)
        gameOverFrame.addChild(titleLabel)
    }
    
    //MARK: Win frame
    
    private func createWinFrame() {
        winFrame = SKSpriteNode(imageNamed: "frameForAction")
        winFrame.position = CGPoint(x: size.width / 2, y: size.height / 2)
        winFrame.size = CGSize(width: 240, height: 192)
        winFrame.zPosition = 1
        
        let titleLabel = SKLabelNode(text: "You Win")
        titleLabel.fontName = "CherryBombOne-Regular"
        titleLabel.fontSize = 32
        titleLabel.fontColor = .white
        titleLabel.position = CGPoint(x: 0, y: 45)
        
        let homeButton = createButton(named: "homeButton", size: CGSize(width: 72, height: 72), position: CGPoint(x: -40, y: -10), name: "home_button")
        let updateButton = createButton(named: "nextBtn", size: CGSize(width: 72, height: 72), position: CGPoint(x: 40, y: -10), name: "next_button")
        
        winFrame.isHidden = true
        addChild(winFrame)
        winFrame.addChild(homeButton)
        winFrame.addChild(updateButton)
        winFrame.addChild(titleLabel)
    }
    
    //MARK: BACKGROUND
    private func setupBackground() {
        background = SKSpriteNode(imageNamed: "bg")
        background.position = CGPoint(x: size.width / 2, y: size.height / 2)
        background.size = CGSize(width: size.width, height: size.height)
        background.zPosition = -1
        addChild(background)
    }
    
    //MARK: Back Button (Arrow)
    private func setupPauseButton() {
        pauseButton = createButton(named: "pausedBtn", size: CGSize(width: 32, height: 32), position: CGPoint(x: 60, y: size.height - 60), name: "pause_button")
        pauseButton.anchorPoint = CGPoint(x: 1.0, y: 1.0)
        addChild(pauseButton)
    }
    
    
    //MARK: Image Button Creation
    private func createButton(named imageName: String, size: CGSize, position: CGPoint, name: String) -> SKSpriteNode {
        let button = SKSpriteNode(imageNamed: imageName)
        button.size = size
        button.position = position
        button.name = name
        return button
    }
    

    private func addSingleTooth(to ring: SKShapeNode, toothSize: CGSize, radius: CGFloat, angle: CGFloat, offset: CGFloat = 0) {
  
        let tooth = SKShapeNode()
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: -toothSize.height / 2))
        path.addLine(to: CGPoint(x: -toothSize.width / 2, y: toothSize.height / 2))
        path.addLine(to: CGPoint(x: toothSize.width / 2, y: toothSize.height / 2))
        path.close()
        tooth.path = path.cgPath
        tooth.fillColor = .white
        tooth.strokeColor = .clear
        
     
        let adjustedRadius = radius - 19
        let x = adjustedRadius * cos(angle)
        let y = adjustedRadius * sin(angle)
        tooth.position = CGPoint(x: x, y: y)
        
      
        tooth.zRotation = angle - .pi / 2
        
       
        if let physicsPath = tooth.path {
            tooth.physicsBody = SKPhysicsBody(polygonFrom: physicsPath)
            tooth.physicsBody?.isDynamic = false
            tooth.physicsBody?.categoryBitMask = ballCategory
            tooth.physicsBody?.contactTestBitMask = toothCategory
        }
        
        ring.addChild(tooth)
    }
    
    private func addTeeth(to ring: SKShapeNode, numberOfTeeth: Int, toothSize: CGSize, radius: CGFloat, offset: CGFloat = 0, angleOffset: CGFloat = 0, tightness: CGFloat = 1.0, radiusAdjustment: CGFloat = 0,  toothSizeHeight: CGFloat = 2) {
        let angleIncrement = (2 * .pi) / CGFloat(numberOfTeeth) * tightness
        
        for i in 0..<numberOfTeeth {
            let angle = angleIncrement * CGFloat(i) + angleOffset
            
          
            let adjustedRadius = radius - 19
            
        
            let tooth = SKShapeNode()
            let path = UIBezierPath()
            path.move(to: CGPoint(x: 0, y: -toothSize.height / toothSizeHeight ))
            path.addLine(to: CGPoint(x: -toothSize.width / 2, y: toothSize.height / 2))
            path.addLine(to: CGPoint(x: toothSize.width / 2, y: toothSize.height / 2))
            path.close()
            tooth.path = path.cgPath
            tooth.fillColor = .red
            tooth.strokeColor = .clear
            tooth.zPosition = -1
            
           
            let x = adjustedRadius * cos(angle)
            let y = adjustedRadius * sin(angle)
            tooth.position = CGPoint(x: x, y: y)
            
            
            tooth.zRotation = angle - .pi / 2
            
           
            if let physicsPath = tooth.path {
                tooth.physicsBody = SKPhysicsBody(polygonFrom: physicsPath)
                tooth.physicsBody?.isDynamic = false
                tooth.physicsBody?.categoryBitMask = 2
                tooth.physicsBody?.contactTestBitMask = 1
            }
            
            ring.addChild(tooth)
        }
    }
    
    private func addTeethAsPencils(to ring: SKShapeNode, numberOfTeeth: Int, toothSize: CGSize, radius: CGFloat, offset: CGFloat = 0, angleOffset: CGFloat = 0, tightness: CGFloat = 1.0, radiusAdjustment: CGFloat = 0, toothSizeHeight: CGFloat = 2) {
        let angleIncrement = (2 * .pi) / CGFloat(numberOfTeeth) * tightness
        
        for i in 0..<numberOfTeeth {
            let angle = angleIncrement * CGFloat(i) + angleOffset
            
          
            let adjustedRadius = radius - 19
            
          
            let tooth = SKShapeNode()
            let path = UIBezierPath()
            
           
            let tipPoint = CGPoint(x: 0, y: -toothSize.height / toothSizeHeight)
            let leftBase = CGPoint(x: -toothSize.width / 2, y: toothSize.height / 2)
            let rightBase = CGPoint(x: toothSize.width / 2, y: toothSize.height / 2)
            
           
            path.move(to: tipPoint)
            path.addLine(to: leftBase)
            path.addLine(to: rightBase)
            path.close()
            
            tooth.path = path.cgPath
            tooth.fillColor = .red
            tooth.strokeColor = .clear
            tooth.zPosition = -1
            
           
            let x = adjustedRadius * cos(angle)
            let y = adjustedRadius * sin(angle)
            tooth.position = CGPoint(x: x, y: y)
            
           
            tooth.zRotation = angle - .pi / 2
            
          
            if let physicsPath = tooth.path {
                tooth.physicsBody = SKPhysicsBody(polygonFrom: physicsPath)
                tooth.physicsBody?.isDynamic = false
                tooth.physicsBody?.categoryBitMask = 2
                tooth.physicsBody?.contactTestBitMask = 1
            }
            
            ring.addChild(tooth)
        }
    }
    
    //MARK: UPPER RING
    private func createUpperRing() {
       
        let pathUpper = UIBezierPath(arcCenter: .zero, radius: radius, startAngle: startAngleUpper, endAngle: endAngleUpper, clockwise: true)
        upperRing = SKShapeNode(path: pathUpper.cgPath)
        upperRing.strokeColor = SKColor(red: 0.5, green: 1.0, blue: 0.5, alpha: 1.0)
        upperRing.lineWidth = 20
        upperRing.lineCap = .round
        
      
        upperRing.position = CGPoint(x: size.width / 2, y: size.height / 2 + 150)
        addChild(upperRing)
        
       
        let offset = -14.0
        let offsetPath = UIBezierPath(arcCenter: .zero, radius: radius + offset, startAngle: startAngleUpper, endAngle: endAngleUpper, clockwise: true)
        upperRing.physicsBody = SKPhysicsBody(edgeChainFrom: offsetPath.cgPath)
        upperRing.physicsBody?.isDynamic = false
        upperRing.physicsBody?.affectedByGravity = false
        upperRing.physicsBody?.restitution = 0
        upperRing.physicsBody?.categoryBitMask = innerContourCategory
        upperRing.physicsBody?.contactTestBitMask = ballCategory
        
        
        let borderRadius = radius + 13
        let borderPath = UIBezierPath(arcCenter: .zero, radius: borderRadius, startAngle: startAngleUpper, endAngle: endAngleUpper, clockwise: true)
        let borderRing = SKShapeNode(path: borderPath.cgPath)
        borderRing.strokeColor = SKColor(red: 0.5, green: 1.0, blue: 0.5, alpha: 1.0)
        borderRing.lineWidth = 0
        borderRing.lineCap = .round
        
      
        borderRing.physicsBody = SKPhysicsBody(edgeChainFrom: borderPath.cgPath)
        borderRing.physicsBody?.isDynamic = false
        borderRing.physicsBody?.affectedByGravity = false
        borderRing.physicsBody?.restitution = 0
        borderRing.physicsBody?.categoryBitMask = outerContourCategory
        borderRing.physicsBody?.contactTestBitMask = ballCategory
        
        
        borderRing.position = CGPoint(x: size.width / 2, y: size.height / 2 + 150)
        addChild(borderRing)
        
        
        let rotateActionUpper = SKAction.rotate(byAngle: -.pi * 2, duration: durationRings)
        let repeatActionUpper = SKAction.repeatForever(rotateActionUpper)
        upperRing.run(repeatActionUpper)
        borderRing.run(repeatActionUpper)
    }
    
    
    //MARK: LOWER RING
    private func createLowerRing() {
        
        let pathLower = UIBezierPath(arcCenter: .zero, radius: radius, startAngle: startAngleLower, endAngle: endAngleLower, clockwise: true)
        lowerRing = SKShapeNode(path: pathLower.cgPath)
        lowerRing.strokeColor = SKColor(red: 0.5, green: 1.0, blue: 0.5, alpha: 1.0)
        lowerRing.lineWidth = 20
        lowerRing.lineCap = .round
        
       
        lowerRing.position = CGPoint(x: size.width / 2, y: size.height / 2 - 150)
        addChild(lowerRing)
        
       
        let offset = -14.0
        let offsetPath = UIBezierPath(arcCenter: .zero, radius: radius + offset, startAngle: startAngleLower, endAngle: endAngleLower, clockwise: true)
        lowerRing.physicsBody = SKPhysicsBody(edgeChainFrom: offsetPath.cgPath)
        lowerRing.physicsBody?.isDynamic = false
        lowerRing.physicsBody?.affectedByGravity = false
        lowerRing.physicsBody?.restitution = 0
        lowerRing.physicsBody?.categoryBitMask = innerContourCategory
        lowerRing.physicsBody?.contactTestBitMask = ballCategory
        
        
        let borderRadius = radius + 13
        let borderPath = UIBezierPath(arcCenter: .zero, radius: borderRadius, startAngle: startAngleLower, endAngle: endAngleLower, clockwise: true)
        let borderRing = SKShapeNode(path: borderPath.cgPath)
        borderRing.strokeColor = SKColor(red: 0.5, green: 1.0, blue: 0.5, alpha: 1.0)
        borderRing.lineWidth = 0
        borderRing.lineCap = .round
        
        borderRing.physicsBody = SKPhysicsBody(edgeChainFrom: borderPath.cgPath)
        borderRing.physicsBody?.isDynamic = false
        borderRing.physicsBody?.affectedByGravity = false
        borderRing.physicsBody?.restitution = 0
        borderRing.physicsBody?.categoryBitMask = outerContourCategory
        borderRing.physicsBody?.contactTestBitMask = ballCategory
        
        
      
        borderRing.position = CGPoint(x: size.width / 2, y: size.height / 2 - 150)
        addChild(borderRing)
        
        
        let rotateActionLower = SKAction.rotate(byAngle: .pi * 2, duration: durationRings)
        let repeatActionLower = SKAction.repeatForever(rotateActionLower)
        lowerRing.run(repeatActionLower)
        borderRing.run(repeatActionLower)
    }
    
    //MARK: BALL
    private func createBall() {
     
        ball = SKShapeNode(circleOfRadius: 15)
        ball.fillColor = .white
        
        ball.strokeColor = .clear
        ball.position = CGPoint(x: size.width / 2, y: size.height / 2 + 150)
        addChild(ball)
        
 
        ball.physicsBody = SKPhysicsBody(circleOfRadius: 10)
        ball.physicsBody?.isDynamic = true
        ball.physicsBody?.affectedByGravity = true
        ball.physicsBody?.allowsRotation = false
        ball.physicsBody?.restitution = 0
        ball.physicsBody?.categoryBitMask = 1
 
        ball.physicsBody?.contactTestBitMask = toothCategory | finishCategory | innerContourCategory | outerContourCategory
        
       
        let range = SKRange(lowerLimit: ball.position.x, upperLimit: ball.position.x)
        let lockToCenterX = SKConstraint.positionX(range)
        ball.constraints = [lockToCenterX]
    }
    
    //MARK: TOUCHES BEGAN
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        
      
        if let node = atPoint(location) as? SKSpriteNode {
            if node.name == "pause_button" {
                handleButtonClick(node: node)
                return
            }
            
            if node.name == "update_button" {
                handleButtonClick(node: node)
                return
            }
            
            if node.name == "home_button" {
                handleButtonClick(node: node)
                return
            }
            if node.name == "close_button" {
                handleButtonClick(node: node)
                return
            }
            if node.name == "next_button" {
                handleButtonClick(node: node)
                return
            }
            
        }
        
        if pauseFrame.isHidden == true{
          
            if !gameOver && ballJumpCount < maxJumps {
                if let vm = vm {
                    if vm.isOnSound {
                        AudioManager.audioManager.playClickSound()
                    }
                    if vm.isOnVibration {
                        vm.triggerVibration()
                    }
                }
                    
                ball.physicsBody?.velocity.dy = 0
                ball.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 6))
                ballJumpCount += 1
            }
        }
    }
    
    //MARK: FINISH
    private func createFinish() {
        let startAngle: CGFloat = .pi
        let endAngle: CGFloat = 0
        
        // Создаем финиш
        let pathLower = UIBezierPath(arcCenter: .zero, radius: 30, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        finish = SKShapeNode(path: pathLower.cgPath)
        finish.strokeColor = .white
        finish.lineWidth = 10
        
        
        finish.position = CGPoint(x: size.width / 2, y: 60)
        addChild(finish)
        
  
        let offset = -10.0
        let offsetPath = UIBezierPath(arcCenter: .zero, radius: 30 + offset, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        finish.physicsBody = SKPhysicsBody(edgeChainFrom: offsetPath.cgPath)
        finish.physicsBody?.isDynamic = false
        finish.physicsBody?.affectedByGravity = false
        finish.physicsBody?.restitution = 0
        finish.physicsBody?.categoryBitMask = finishCategory
        finish.physicsBody?.contactTestBitMask = ballCategory
        
    
        let rectangleHeight: CGFloat = 40
        let rectangleWidth: CGFloat = finish.lineWidth
        
        let rectanglePath = UIBezierPath(roundedRect: CGRect(x: -rectangleWidth / 2, y: 0, width: rectangleWidth, height: rectangleHeight), cornerRadius: rectangleWidth / 2)
        let rectangleNode = SKShapeNode(path: rectanglePath.cgPath)
        rectangleNode.fillColor = .white
        rectangleNode.strokeColor = .clear
        
        
        rectangleNode.position = CGPoint(x: 0, y: -rectangleHeight * 1.8)
        
   
        finish.addChild(rectangleNode)
        
    }
    
    //MARK: COLLISION HANDLING
    func didBegin(_ contact: SKPhysicsContact) {
        let firstBody = contact.bodyA
        let secondBody = contact.bodyB
        

        checkCollisionWithTooth(firstBody, secondBody)
        checkCollisionWithOuterCountor(firstBody, secondBody)
        checkCollisionWithInnerCountor(firstBody, secondBody)
        checkCollisionWithFinish(firstBody, secondBody)
    }
    
    
    
    
    private func handleButtonClick(node: SKSpriteNode) {
        guard let name = node.name else { return }
        
        let scaleDown = SKAction.scale(to: 0.9, duration: 0.1)
        let scaleUp = SKAction.scale(to: 1.0, duration: 0.1)
        let sequence = SKAction.sequence([scaleDown, scaleUp])
        node.run(sequence)
        
        switch name {
        case "pause_button":
          
            if let vm = vm {
                if vm.isOnSound {
                    AudioManager.audioManager.playClickSound()
                }
                if vm.isOnVibration {
                    vm.triggerVibration()
                }
            }
                    
          
            if !gameOver {
                isPaused = true
                pauseFrame.isHidden.toggle()
                pauseButton.isHidden = !pauseFrame.isHidden
            }
        case "update_button":
            if let vm = vm {
                if vm.isOnSound {
                    AudioManager.audioManager.playClickSound()
                }
                if vm.isOnVibration {
                    vm.triggerVibration()
                }
            }
//            self.clearScene()
            if let sceneController = sceneController {
                
                 self.removeAllChildren()
                 self.removeAllActions()
                 
           
                 let newScene = GameScene(size: CGSize(width: 400, height: 800))
                 newScene.sceneController = sceneController
                 newScene.vm = vm
                 newScene.currentLevel = currentLevel
                 newScene.scaleMode = .resizeFill

                
                 let transition = SKTransition.fade(withDuration: 1)
                 self.view?.presentScene(newScene, transition: transition)
             }
        case "home_button":
            if let vm = vm {
                if vm.isOnSound {
                    AudioManager.audioManager.playClickSound()
                }
                if vm.isOnVibration {
                    vm.triggerVibration()
                }
            }
            clearScene()
            vm?.selectedApp = .lvl
//            self.onDismiss?()
//                self.onDismiss = nil
           
         
        case "close_button":
            if let vm = vm {
                if vm.isOnSound {
                    AudioManager.audioManager.playClickSound()
                }
                if vm.isOnVibration {
                    vm.triggerVibration()
                }
            }
            isPaused = false
            pauseFrame.isHidden.toggle()
            pauseButton.isHidden = !pauseFrame.isHidden
        case "next_button":
            if let vm = vm {
                if vm.isOnSound {
                    AudioManager.audioManager.playClickSound()
                }
                if vm.isOnVibration {
                    vm.triggerVibration()
                }
            }
            
          
            if let sceneController = sceneController {
                
                clearScene()
                sceneController.updateLevelState(levelIndex: currentLevel, isOpen: true, isFinished: true)
                
          
                let nextLevelIndex = currentLevel + 1
                if nextLevelIndex < sceneController.levelStates.count {
                    sceneController.updateLevelState(levelIndex: nextLevelIndex, isOpen: true, isFinished: false)
                    
                   
                    let newScene = GameScene(size: self.size)
                    newScene.sceneController = sceneController
                    newScene.currentLevel = nextLevelIndex
                    newScene.vm = vm
                    newScene.scaleMode = .resizeFill
                    
             
                    let transition = SKTransition.fade(withDuration: 0.5)
                    self.view?.presentScene(newScene, transition: transition)
                } else {
//                    print("No more levels!")
                   
                }
            }
            
            
        default:
            break
        }
    }
    
    func clearScene() {
        self.removeAllChildren()
        self.removeAllActions()
//        self.physicsWorld.removeAllJoints()
//        self.physicsWorld.removeAllBodies()
    }
//    
    private func stopScene() {
        isPaused = true
        
    }
    deinit {
//            print("GameScene deinitialized")
        }
    
}

struct GameSceneView: View {
    @State private var sceneID = UUID()
    @EnvironmentObject private var sceneController: SceneController
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var vm: ViewModel
    let index: Int

    var body: some View {
        ZStack {
            SpriteView(scene: sceneController.currentScene)
                .id(sceneID)
                .ignoresSafeArea()
        }
        .onAppear {
        
            let newScene = GameScene(size: sceneController.currentScene.size)
            newScene.sceneController = sceneController
            newScene.vm = vm
            newScene.currentLevel = index
            newScene.scaleMode = .resizeFill
//            newScene.onDismiss = { 
//                print("Dismissing scene...")
//                sceneID = UUID()
//                dismiss()
//            }
            
            sceneController.currentScene = newScene
        }
        .onDisappear {
       
        }
        .onChange(of: vm.selectedApp) {  newValue in
            print(vm.selectedApp)
        }
       
    }
}

#Preview {
    GameSceneView(index: 0)
        .withAutoPreviewEnvironment()
        .environmentObject(SceneController())
}


extension GameScene{
  
    private func checkCollisionWithTooth(_ firstBody: SKPhysicsBody, _ secondBody: SKPhysicsBody){
        if (firstBody.categoryBitMask == ballCategory && secondBody.categoryBitMask == toothCategory) ||
            (firstBody.categoryBitMask == toothCategory && secondBody.categoryBitMask == ballCategory) {
            gameOver = true
//            print("Collision with tooth! Game Over!")
            stopScene()
                        gameOverFrame.isHidden = false
        }
    }
    
    private func checkCollisionWithOuterCountor(_ firstBody: SKPhysicsBody, _ secondBody: SKPhysicsBody){
        if !gameOver &&  ((firstBody.categoryBitMask == ballCategory && secondBody.categoryBitMask == outerContourCategory) ||
                          (firstBody.categoryBitMask == outerContourCategory && secondBody.categoryBitMask == ballCategory)) {
            gameOver = true
//            print("Game Over - innet Countour")
            stopScene()
                        gameOverFrame.isHidden = false
        }
    }

    private func checkCollisionWithInnerCountor(_ firstBody: SKPhysicsBody, _ secondBody: SKPhysicsBody){
        if (firstBody.categoryBitMask == ballCategory && secondBody.categoryBitMask == innerContourCategory) ||
            (firstBody.categoryBitMask == innerContourCategory && secondBody.categoryBitMask == ballCategory) {
            if ballJumpCount != 0 {
                ballJumpCount = 0
//                print("Count JUMP 0 ")
            }
        }
    }
   
    private func checkCollisionWithFinish(_ firstBody: SKPhysicsBody, _ secondBody: SKPhysicsBody){
        if !gameOver && ((firstBody.categoryBitMask == ballCategory && secondBody.categoryBitMask == finishCategory) ||
                         (firstBody.categoryBitMask == finishCategory && secondBody.categoryBitMask == ballCategory)) {
//            print("Finish reached!")
            gameOver = true
            durationRings = 10
            
            upperRing.removeAllActions()
            lowerRing.removeAllActions()
            
            let slowRotateUpper = SKAction.rotate(byAngle: -.pi * 2, duration: durationRings)
            let slowRotateLower = SKAction.rotate(byAngle: .pi * 2, duration: durationRings)
            
            upperRing.run(SKAction.repeatForever(slowRotateUpper))
            lowerRing.run(SKAction.repeatForever(slowRotateLower))
            
            winFrame.isHidden = false
            
            sceneController?.updateLevelState(levelIndex: currentLevel, isOpen: true, isFinished: true)
            let nextLevelIndex = currentLevel + 1
            if nextLevelIndex < sceneController?.levelStates.count ?? 0 {
                sceneController?.updateLevelState(levelIndex: nextLevelIndex, isOpen: true, isFinished: false)
                
            }
        }
    }
    
}


