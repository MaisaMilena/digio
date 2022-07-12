import Foundation
import UIKit

protocol ShowcaseCarouselDelegate: AnyObject {
    func didLayoutItems()
    func didTapItem(at position: Int)
}

public protocol ShowcaseProtocol: UIView {
    func layout(viewModels: [ImagePresentationViewModel])
}

extension ShowcaseCarousel: ShowcaseProtocol {
    func layout(viewModels: [ImagePresentationViewModel]) {
        elements = viewModels
        imageFactory = SpotlightFactory()
    }
}

extension ShowcaseCarousel.Layout {
    enum Highlight {
        static let carouselHeight = 200
    }
}

final class ShowcaseCarousel: UIView {
    enum Layout {}
    
    private var elements: [ImagePresentationViewModel] = []
    private var imageFactory: ImageFactoryProtocol?
    private var delegate: ShowcaseCarouselDelegate
    
    private lazy var carousel: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
        let collection = UICollectionView(frame: self.frame, collectionViewLayout: layout)
        collection.delegate = self
        collection.dataSource = self
//        collection.showsHorizontalScrollIndicator = false
        collection.isScrollEnabled = true
        collection.isUserInteractionEnabled = true
//        collection.isAccessibilityElement = true
        collection.register(
            ShowcaseCell.self,
            forCellWithReuseIdentifier: ShowcaseCell.identifier
        )
        return collection
    }()
    
    init(delegate: ShowcaseCarouselDelegate) {
        self.delegate = delegate
        super.init(frame: .zero)
        addSubview(carousel)
        carousel.snp.makeConstraints {
            $0.height.equalTo(Layout.Highlight.carouselHeight)
            $0.width.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ShowcaseCarousel: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        elements.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ShowcaseCell.identifier,
            for: indexPath
        ) as? ShowcaseCell
        let content = elements[indexPath.row]
        guard let factory = imageFactory else {
            return UICollectionViewCell()
        }
        cell?.addBanner(factory.make(content))
        cell?.layoutIfNeeded()
        return cell ?? UICollectionViewCell()
    }
}

extension ShowcaseCarousel: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        Sentinel.info("indexPath: \(indexPath)")
        delegate.didTapItem(at: indexPath.row)
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        Sentinel.event("collect width: \(collectionView.frame.size.width)")
        return CGSize(width: collectionView.frame.size.width - 50, height: collectionView.frame.size.height)
    }
}
