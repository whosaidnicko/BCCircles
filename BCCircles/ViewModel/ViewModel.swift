import SwiftUI

final class ViewModel: ObservableObject {
    
    @Published var selectedApp: AppViews = .loading
    
    @Published var indexLvl: Int = 0
    @Published var isOnSound:Bool = false
    @Published var isOnMusic:Bool = false
    @Published var isOnVibration:Bool = false
    

    func triggerVibration() {
          let feedbackGenerator = UIImpactFeedbackGenerator(style: .heavy)
          feedbackGenerator.prepare()
          feedbackGenerator.impactOccurred()
      }
    
    init() {
    
    }
    
 
    
}


enum AppViews {
    case loading
    case welcome
    case main
    case lvl
    case game
    
}
