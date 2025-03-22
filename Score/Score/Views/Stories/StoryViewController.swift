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

    private let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    var onClose: (() -> Void)?

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
        setupCloseButton()
    }

    private func setupCloseButton() {
        view.addSubview(closeButton)

        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            closeButton.widthAnchor.constraint(equalToConstant: 30),
            closeButton.heightAnchor.constraint(equalToConstant: 30),
        ])

        closeButton.addTarget(self, action: #selector(didTapClose), for: .touchUpInside)
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

    @objc private func didTapClose() {
        dismiss(animated: true) {
            self.onClose?()
        }
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
