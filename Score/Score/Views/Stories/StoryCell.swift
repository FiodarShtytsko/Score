//
//  StoryCell.swift
//  Score
//
//  Created by Fiodar Shtytsko on 22/03/2025.
//


import UIKit
import AVFoundation

final class StoryCell: UICollectionViewCell {
    static let identifier = "StoryCell"

    private var playerLayer: AVPlayerLayer?
    private var player: AVPlayer?
    private var queuePlayer: AVQueuePlayer?
    private var playerLooper: AVPlayerLooper?


    override func prepareForReuse() {
        super.prepareForReuse()
        playerLayer?.removeFromSuperlayer()
        player?.pause()
        player = nil
    }

    func configure(with page: StoryPage) {
        let playerItem = AVPlayerItem(url: page.videoURL)
        queuePlayer = AVQueuePlayer()
        playerLooper = AVPlayerLooper(player: queuePlayer!, templateItem: playerItem)

        playerLayer?.removeFromSuperlayer()
        playerLayer = AVPlayerLayer(player: queuePlayer)
        playerLayer?.frame = contentView.bounds
        playerLayer?.videoGravity = .resizeAspectFill

        if let layer = playerLayer {
            contentView.layer.addSublayer(layer)
        }

        queuePlayer?.play()
    }
}
