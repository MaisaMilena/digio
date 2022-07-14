import Foundation
import UIKit

protocol ShowcaseCarouselDelegate: AnyObject {
    func didLayoutItems()
    func didTapItem(at position: Int)
}

public protocol ShowcaseProtocol: AnyObject {
    var carousel: UICollectionView { get set }
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
        static let rightSpacing: CGFloat = 50
    }
    
    enum Spacing {
        static let horizontal: CGFloat = 30
    }
}

final class ShowcaseCarousel: UIViewController {
    enum Layout {}
    
    private var elements: [ImagePresentationViewModel] = []
    private var imageFactory: ImageFactoryProtocol?
    private weak var delegate: (ShowcaseCarouselDelegate)?
    
    internal lazy var carousel: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.minimumLineSpacing = Layout.Spacing.horizontal
        layout.minimumInteritemSpacing = Layout.Spacing.horizontal
        
        let collection = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collection.delegate = self
        collection.dataSource = self
        collection.showsHorizontalScrollIndicator = false
        collection.isUserInteractionEnabled = true
        collection.register(
            ShowcaseCell.self,
            forCellWithReuseIdentifier: ShowcaseCell.identifier
        )
        return collection
    }()
    
    init(delegate: ShowcaseCarouselDelegate) {
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
        view.addSubview(carousel)
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
        cell?.setNeedsLayout()
        cell?.layoutIfNeeded()
        return cell ?? UICollectionViewCell()
    }
}

extension ShowcaseCarousel: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didTapItem(at: indexPath.row)
    }
}

extension ShowcaseCarousel: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(
            width: collectionView.frame.size.width - Layout.Highlight.rightSpacing,
            height: collectionView.frame.size.height
        )
    }
}
