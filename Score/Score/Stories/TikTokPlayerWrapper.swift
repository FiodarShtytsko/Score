//
//  TikTokPlayerWrapper.swift
//  Score
//
//  Created by Fiodar Shtytsko on 22/03/2025.
//

import SwiftUI

struct TikTokPlayerWrapper: UIViewControllerRepresentable {
    let pages: [StoryPage]
    let onClose: () -> Void

    
    func makeUIViewController(context: Context) -> StoryViewController {
        let controller = StoryViewController(pages: pages)
        controller.onClose = onClose
        return controller
    }


    func updateUIViewController(_ uiViewController: StoryViewController, context: Context) { }
}
