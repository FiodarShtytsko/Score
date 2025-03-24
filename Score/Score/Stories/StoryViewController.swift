//
//  StoryViewController.swift
//  Score
//
//  Created by Fiodar Shtytsko on 22/03/2025.
//


import UIKit

final class StoryViewController: UIViewController {
    private let pages: [StoryPage]

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = .zero

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(StoryCell.self, forCellWithReuseIdentifier: StoryCell.identifier)
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .black
        return collectionView
    }()

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

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }

        let newSize = view.bounds.size
        if layout.itemSize != newSize {
            layout.itemSize = newSize
            layout.invalidateLayout()
        }
    }

    private func setupCloseButton() {
        view.addSubview(closeButton)
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Layout.closeButtonPadding),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Layout.closeButtonPadding),
            closeButton.widthAnchor.constraint(equalToConstant: Layout.closeButtonSize),
            closeButton.heightAnchor.constraint(equalToConstant: Layout.closeButtonSize),
        ])

        closeButton.addTarget(self, action: #selector(didTapClose), for: .touchUpInside)
    }

    private func setupCollectionView() {
        view.addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
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

private extension StoryViewController {
    enum Layout {
        static let closeButtonSize: CGFloat = 30
        static let closeButtonPadding: CGFloat = 16
    }
}
