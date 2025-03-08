import SwiftUI
import SpriteKit
import StoreKit

class SceneController: ObservableObject {
    
    @Published var currentScene: SKScene
    
 
    @Published var levelStates: [LvlModel]
    
    init() {
        
        
        self.levelStates = []
        
        self.currentScene = GameScene(size: CGSize(width: 400, height: 800))
        
        self.currentScene.scaleMode = .resizeFill
        self.levelStates = self.loadLevelStates()
        
        
    }
    func startGame(withLevel level: Int) {
        let newScene = GameScene(size: CGSize(width: 400, height: 800))
        newScene.sceneController = self
        newScene.currentLevel = level
        newScene.scaleMode = .resizeFill
        
        // Плавная анимация для перехода
        if let view = self.currentScene.view {
            let transition = SKTransition.fade(withDuration: 0.5) // Плавный переход
            view.presentScene(newScene, transition: transition)
        }
        
        // Обновляем currentScene, но это только для внутреннего состояния
        self.currentScene = newScene
    }
    
    
    
    func loadLevelStates() -> [LvlModel] {
        if let savedData = UserDefaults.standard.data(forKey: "levelStates") {
            let decoder = JSONDecoder()
            if let decodedStates = try? decoder.decode([LvlModel].self, from: savedData) {
                return decodedStates
            }
        }
        
        return self.initializeLevelStates()
    }
    
    func saveLevelStates() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(levelStates) {
            UserDefaults.standard.set(encoded, forKey: "levelStates")
        }
    }
    
    
    func initializeLevelStates() -> [LvlModel] {
        var levelStates: [LvlModel] = []
        
        for levelIndex in 0..<16 {
            let state = LvlModel(levelIndex: levelIndex, isOpen: levelIndex == 0, isFinished: false)
            levelStates.append(state)
        }
        
        return levelStates
    }
    

    func updateLevelState(levelIndex: Int, isOpen: Bool, isFinished: Bool) {
        if let index = levelStates.firstIndex(where: { $0.levelIndex == levelIndex }) {
            levelStates[index].isOpen = isOpen
            levelStates[index].isFinished = isFinished
            saveLevelStates()
            
//            print("Level \(levelIndex) updated: isOpen = \(isOpen), isFinished = \(isFinished)")
        }
    }
    
    
    let levels: [LevelHightModel] = [
        // 1
        LevelHightModel(
            upperRingTeethCount: 1,
            lowerRingTeethCount: 2,
            toothSize: CGSize(width: 20, height: 20),
            radius: 100,
            leftAngleOffset: .pi + 14.1456,
            rightAngleOffset: 0,
            leftTightness: 1.0,
            rightTightness: 1.0,
            leftRadiusAdjustment: 0,
            rightRadiusAdjustment: 0,
            leftToothSizeHeight: 2,
            rightToothSizeHeight: 2
        ),
        
        // 2
        LevelHightModel(
            upperRingTeethCount: 2,
            lowerRingTeethCount: 2,
            toothSize: CGSize(width: 20, height: 20),
            radius: 100,
            leftAngleOffset: 10.0,
            rightAngleOffset: 10.0,
            leftTightness: 1.0,
            rightTightness: 1.0,
            leftRadiusAdjustment: 0,
            rightRadiusAdjustment: 0,
            leftToothSizeHeight: 2,
            rightToothSizeHeight: 2
        ),
        
        // 3
        LevelHightModel(
            upperRingTeethCount: 4,
            lowerRingTeethCount: 4,
            toothSize: CGSize(width: 20, height: 20),
            radius: 100,
            leftAngleOffset: 4.0,
            rightAngleOffset: 4.0,
            leftTightness: 1.0,
            rightTightness: 1.0,
            leftRadiusAdjustment: 0,
            rightRadiusAdjustment: 0,
            leftToothSizeHeight: 2,
            rightToothSizeHeight: 2
        ),
        
        //
        // 4
        LevelHightModel(
            upperRingTeethCount: 6,
            lowerRingTeethCount: 6,
            toothSize: CGSize(width: 20, height: 20),
            radius: 100,
            leftAngleOffset: 0.0,
            rightAngleOffset: 0.0,
            leftTightness: 1.0,
            rightTightness: 1.0,
            leftRadiusAdjustment: 0,
            rightRadiusAdjustment: 0,
            leftToothSizeHeight: 2,
            rightToothSizeHeight: 2
        ),
        
        // 5
        LevelHightModel(
            upperRingTeethCount: 4,
            lowerRingTeethCount: 7,
            toothSize: CGSize(width: 20, height: 20),
            radius: 100,
            leftAngleOffset: .pi + 9.1,
            rightAngleOffset: 0,
            leftTightness: 0.8,
            rightTightness: 1.5,
            leftRadiusAdjustment: -10.0,
            rightRadiusAdjustment: 10.0,
            leftToothSizeHeight:2,
            rightToothSizeHeight:2
        ),
        
        // 6
        LevelHightModel(
            upperRingTeethCount: 4,
            lowerRingTeethCount: 6,
            toothSize: CGSize(width: 20, height: 20),
            radius: 100,
            leftAngleOffset: .pi + 9.1,
            rightAngleOffset: 4,
            leftTightness: 0.8,
            rightTightness: 1.5,
            leftRadiusAdjustment: -10.0,
            rightRadiusAdjustment: 10.0,
            leftToothSizeHeight: 2,
            rightToothSizeHeight: 2
        ),
        
        // 7
        LevelHightModel(
            upperRingTeethCount: 1,
            lowerRingTeethCount: 2,
            toothSize: CGSize(width: 20, height: 40),
            radius: 100,
            leftAngleOffset: .pi + 15.1456,
            rightAngleOffset: 0,
            leftTightness: 1.0,
            rightTightness: 1.0,
            leftRadiusAdjustment: 0,
            rightRadiusAdjustment: 0,
            leftToothSizeHeight: 1.0,
            rightToothSizeHeight: 1.4
        ),
        
        // 8
        LevelHightModel(
            upperRingTeethCount: 5,
            lowerRingTeethCount: 6,
            toothSize: CGSize(width: 20, height: 40),
            radius: 100,
            leftAngleOffset: .pi + 14.1456,
            rightAngleOffset: 0,
            leftTightness: 1.0,
            rightTightness: 1.0,
            leftRadiusAdjustment: 0,
            rightRadiusAdjustment: 0,
            leftToothSizeHeight: 2,
            rightToothSizeHeight: 2
        ),
        
        // 9
        LevelHightModel(
            upperRingTeethCount: 2,
            lowerRingTeethCount: 3,
            toothSize: CGSize(width: 20, height: 40),
            radius: 100,
            leftAngleOffset: .pi + 12.1456,
            rightAngleOffset: .pi + 11.1456,
            leftTightness: 1.0,
            rightTightness: 1.0,
            leftRadiusAdjustment: 1.0,
            rightRadiusAdjustment: 1.0,
            leftToothSizeHeight: 1.7,
            rightToothSizeHeight: 1.4
        ),
        
        // 10
        LevelHightModel(
            upperRingTeethCount: 2,
            lowerRingTeethCount: 2,
            toothSize: CGSize(width: 20, height: 40),
            radius: 100,
            leftAngleOffset: .pi + 15.1456,
            rightAngleOffset: 0,
            leftTightness: 1.0,
            rightTightness: 1.0,
            leftRadiusAdjustment: 1.0,
            rightRadiusAdjustment: 1.0,
            leftToothSizeHeight: 1.4,
            rightToothSizeHeight: 1.4
        ),
        
        // 11
        LevelHightModel(
            upperRingTeethCount: 2,
            lowerRingTeethCount: 3,
            toothSize: CGSize(width: 20, height: 40),
            radius: 100,
            leftAngleOffset: .pi + 12.1456,
            rightAngleOffset: .pi + 11.1456,
            leftTightness: 1.0,
            rightTightness: 1.0,
            leftRadiusAdjustment: 1.0,
            rightRadiusAdjustment: 1.0,
            leftToothSizeHeight: 2.0,
            rightToothSizeHeight: 1.0
        ),
        
        // 12
        LevelHightModel(
            upperRingTeethCount: 3,
            lowerRingTeethCount: 3,
            toothSize: CGSize(width: 20, height: 40),
            radius: 100,
            leftAngleOffset: .pi + 12.1456,
            rightAngleOffset: .pi + 11.1456,
            leftTightness: 1.4,
            rightTightness: 1.0,
            leftRadiusAdjustment: 1.0,
            rightRadiusAdjustment: 1.0,
            leftToothSizeHeight: 1.4,
            rightToothSizeHeight: 1.0
        ),
        
        // 13
        LevelHightModel(
            upperRingTeethCount: 1,
            lowerRingTeethCount: 2,
            toothSize: CGSize(width: 20, height: 40),
            radius: 100,
            leftAngleOffset: .pi + 15.1456,
            rightAngleOffset: .pi + 15.1456,
            leftTightness: 1.0,
            rightTightness: 1.0,
            leftRadiusAdjustment: 1.0,
            rightRadiusAdjustment: 1.0,
            leftToothSizeHeight: 1.0,
            rightToothSizeHeight: 1.0
        ),
        
        // 14
        LevelHightModel(
            upperRingTeethCount: 1,
            lowerRingTeethCount: 2,
            toothSize: CGSize(width: 20, height: 40),
            radius: 100,
            leftAngleOffset: .pi + 15.1456,
            rightAngleOffset: .pi + 15.1456,
            leftTightness: 1.0,
            rightTightness: 1.0,
            leftRadiusAdjustment: 1.0,
            rightRadiusAdjustment: 1.0,
            leftToothSizeHeight: 1.0,
            rightToothSizeHeight: 1.0
        ),
        
        // 15
        LevelHightModel(
            upperRingTeethCount: 1,
            lowerRingTeethCount: 2,
            toothSize: CGSize(width: 20, height: 40),
            radius: 100,
            leftAngleOffset: .pi + 15.1456,
            rightAngleOffset: .pi + 15.1456,
            leftTightness: 1.0,
            rightTightness: 1.0,
            leftRadiusAdjustment: 1.0,
            rightRadiusAdjustment: 1.0,
            leftToothSizeHeight: 1.0,
            rightToothSizeHeight: 1.0
        ),
        
        // 16
        LevelHightModel(
            upperRingTeethCount: 1,
            lowerRingTeethCount: 2,
            toothSize: CGSize(width: 20, height: 40),
            radius: 100,
            leftAngleOffset: .pi + 15.1456,
            rightAngleOffset: .pi + 15.1456,
            leftTightness: 1.0,
            rightTightness: 1.0,
            leftRadiusAdjustment: 1.0,
            rightRadiusAdjustment: 1.0,
            leftToothSizeHeight: 1.0,
            rightToothSizeHeight: 1.0
        )
    ]
    
    
}


