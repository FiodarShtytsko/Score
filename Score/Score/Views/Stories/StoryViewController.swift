//
//  StoryViewController.swift
//  Score
//
//  Created by Fiodar Shtytsko on 22/03/2025.
//


import UIKit

final class StoryViewController: UIViewController {

    private let pages: [StoryPage]
    private var collectionView: UICollectionView!

    init(pages: [StoryPage]) {
        self.pages = pages
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }

    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.itemSize = UIScreen.main.bounds.size

        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.register(StoryCell.self, forCellWithReuseIdentifier: StoryCell.identifier)
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.showsVerticalScrollIndicator = false

        view.addSubview(collectionView)
    }
}

extension StoryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        pages.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StoryCell.identifier, for: indexPath) as? StoryCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: pages[indexPath.item])
        return cell
    }
}
