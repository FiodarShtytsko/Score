//
//  StoryViewModel.swift
//  Score
//
//  Created by Fiodar Shtytsko on 24/03/2025.
//

import AVFoundation

final class StoryViewModel {
    private let pages: [StoryPage]
    private var cache: [Int: AVPlayerItem] = [:]

    init(pages: [StoryPage]) {
        self.pages = pages
    }

    func page(at index: Int) -> StoryPage {
        pages[index]
    }

    func numberOfPages() -> Int {
        pages.count
    }

    func prefetchItems(at indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            guard cache[indexPath.item] == nil else { continue }
            let item = AVPlayerItem(url: pages[indexPath.item].videoURL)
            cache[indexPath.item] = item
        }
    }

    func playerItem(for index: Int) -> AVPlayerItem? {
        cache[index]
    }
}
