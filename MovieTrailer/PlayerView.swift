//
//  PlayerView.swift
//  MovieTrailer
//
//  Created by 희철 on 2022/01/07.
//

import UIKit
import AVFoundation
/// A view that displays the visual contents of a player object.
class PlayerView: UIView {

    // Override the property to make AVPlayerLayer the view's backing layer.
    override static var layerClass: AnyClass { return AVPlayerLayer.self }
    
    // The associated player object.
    var player: AVPlayer? {
        get {
            return playerLayer.player
        }
        set {
            playerLayer.player = newValue
        }
    }
    
    private var playerLayer: AVPlayerLayer { layer as! AVPlayerLayer }
}
