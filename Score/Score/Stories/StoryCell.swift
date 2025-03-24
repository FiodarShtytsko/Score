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
    private var queuePlayer: AVQueuePlayer?
    private var playerLooper: AVPlayerLooper?

    deinit {
        cleanUpPlayer()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        cleanUpPlayer()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer?.frame = contentView.bounds
    }

    func configure(with page: StoryPage, preloadedItem: AVPlayerItem?) {
        let playerItem = preloadedItem ?? AVPlayerItem(url: page.videoURL)

        queuePlayer = AVQueuePlayer()
        guard let queuePlayer else { return }
        playerLooper = AVPlayerLooper(player: queuePlayer, templateItem: playerItem)

        playerLayer?.removeFromSuperlayer()
        playerLayer = AVPlayerLayer(player: queuePlayer)
        playerLayer?.frame = contentView.bounds
        playerLayer?.videoGravity = .resizeAspectFill

        if let layer = playerLayer {
            contentView.layer.addSublayer(layer)
        }

        queuePlayer.play()
    }

    private func cleanUpPlayer() {
        playerLayer?.removeFromSuperlayer()
        playerLayer = nil
        queuePlayer?.pause()
        queuePlayer = nil
        playerLooper = nil
    }
}
