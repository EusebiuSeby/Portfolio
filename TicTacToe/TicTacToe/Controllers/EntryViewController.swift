//
//  EntryViewController.swift
//  TicTacToe
//
//  Created by Pudilic Seby on 25.03.2022.
//

import UIKit
import AVFoundation

class EntryViewController: UIViewController {

    @IBOutlet weak var toeImage: UIImageView!
    @IBOutlet weak var toeLabel: UILabel!
    
    var player: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        playSound()
        toeLabel.transform = CGAffineTransform(rotationAngle: CGFloat.pi * -18 / 180.0)
        toeImage.transform = CGAffineTransform(rotationAngle: CGFloat.pi * 7 / 180.0)
    }
    
    func playSound() {
        let url = Bundle.main.url(forResource: "introSong", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
    
    @IBAction func startGame(_ sender: UIButton) {
        player.setVolume(0.0, fadeDuration: 3.0)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.player.stop()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            self.performSegue(withIdentifier: "goToGame", sender: self)
        }
    }
    
}
