import SpriteKit
import AVFoundation

public class SpaceView: SKView{
    var player: AVAudioPlayer?
    
    public func PlayBackgroundMusic(){
        
        guard let url = Bundle.main.url(forResource: "Sounds/MyComposition", withExtension: "mp3") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategorySoloAmbient)
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            guard let player = player else { return }
            player.numberOfLoops = -1
            player.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
