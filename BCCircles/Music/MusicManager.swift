import SwiftUI
import AVFoundation

final class AudioManager: ObservableObject {
    //    @AppStorage("music") var music = false
    static let audioManager = AudioManager();    private init() { loadClickSound()}
    
    @Published var volumeMusic: CGFloat = 0.5
//    @Published var sonundOn = false
    
    
    private var player: AVAudioPlayer?
    private var clickSoundPlayer: AVAudioPlayer?
    
    private func loadClickSound() {
          if let soundURL = Bundle.main.url(forResource: "click", withExtension: "mp3") {
              do {
                  clickSoundPlayer = try AVAudioPlayer(contentsOf: soundURL)
                  clickSoundPlayer?.prepareToPlay()
              } catch {
//                  print("Failed to load click sound: \(error)")
              }
          }
      }
    
    func playMusic() {
        guard let url = Bundle.main.url(forResource: "music", withExtension: "mp3") else { return }
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.numberOfLoops = -1
            player?.prepareToPlay()
            updatePlayerVolume()
        } catch _ {
        }
        player?.play()
    }
    
  
    
    func stopMusic() {
        player?.stop()
    }
    
    func pauseMusic(){
        player?.pause()
    }
    
    func setVolume(_ volume: Float) {
        player?.volume = volume
    }
    
    func updatePlayerVolume() {
        player?.volume = Float(volumeMusic)
    }
    
    func playClickSound() {
        clickSoundPlayer?.stop()
        clickSoundPlayer?.currentTime = 0
        clickSoundPlayer?.play()
    }
}


