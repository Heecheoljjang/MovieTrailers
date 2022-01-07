//
//  PlayerViewController.swift
//  MovieTrailer
//
//  Created by 희철 on 2022/01/07.
//

import UIKit
import AVFoundation

class PlayerViewController: UIViewController {

    
    @IBOutlet weak var playerView: PlayerView!
    @IBOutlet weak var controlView: UIView!
    @IBOutlet weak var playButton: UIButton!
    
    let player = AVPlayer()
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscapeRight
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playerView.player = player

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        play()
    }
    
    @IBAction func togglePlayButton(_ sender: Any) {
        if player.isPlaying {
            pause()
        } else {
            play()
        }
    }
    
    func play() {
        player.play()
        playButton.isSelected = true

    }
    func pause() {
        player.pause()
        playButton.isSelected = false

    }
    func reset() {
        pause()
        player.replaceCurrentItem(with: nil)
    }

    @IBAction func closeButton(_ sender: Any) {
        reset()
        dismiss(animated: true, completion: nil)
    }
}

extension AVPlayer {
    var isPlaying: Bool {
        guard self.currentItem != nil else {
            return false}
        return self.rate != 0
    }
}

