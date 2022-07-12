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

final class ShowcaseCarousel: UIView {
    private var elements: [ImagePresentationViewModel] = []
    private var imageFactory: ImageFactoryProtocol?
    private var delegate: ShowcaseCarouselDelegate
    
    private lazy var carousel: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = CGSize(width: 300, height: 100)
        
        let collection = UICollectionView(frame: self.frame, collectionViewLayout: layout)
        collection.delegate = self
        collection.dataSource = self
        collection.showsHorizontalScrollIndicator = false
        collection.isScrollEnabled = true
        collection.isUserInteractionEnabled = true
        collection.isAccessibilityElement = true
        collection.register(
            ShowcaseCell.self,
            forCellWithReuseIdentifier: ShowcaseCell.identifier
        )
        return collection
    }()
    
    init(delegate: ShowcaseCarouselDelegate) {
        self.delegate = delegate
        super.init(frame: .zero)
        isUserInteractionEnabled = true
        addSubview(carousel)
        carousel.snp.makeConstraints {
            $0.height.equalTo(150)
            $0.width.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ShowcaseCarousel: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        Sentinel.info("elements: \(elements.count.description)")
        return elements.count
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
        return CGSize(width: collectionView.frame.size.width - 50, height: collectionView.frame.size.height)
    }
}
