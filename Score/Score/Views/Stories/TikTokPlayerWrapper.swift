//
//  TikTokPlayerWrapper.swift
//  Score
//
//  Created by Fiodar Shtytsko on 22/03/2025.
//

import SwiftUI


struct TikTokPlayerWrapper: UIViewControllerRepresentable {
    let pages: [StoryPage]

    func makeUIViewController(context: Context) -> StoryViewController {
        StoryViewController(pages: pages)
    }

    func updateUIViewController(_ uiViewController: StoryViewController, context: Context) { }
}
