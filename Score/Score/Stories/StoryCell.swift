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

    func configure(with page: StoryPage) {
        cleanUpPlayer()

        let playerItem = AVPlayerItem(url: page.videoURL)
        queuePlayer = AVQueuePlayer()

        guard let queuePlayer = queuePlayer else { return }

        playerLooper = AVPlayerLooper(player: queuePlayer, templateItem: playerItem)

        let layer = AVPlayerLayer(player: queuePlayer)
        layer.frame = contentView.bounds
        layer.videoGravity = .resizeAspectFill

        playerLayer = layer
        contentView.layer.addSublayer(layer)

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
