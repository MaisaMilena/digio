//import Foundation
//import UIKit
//
//protocol ShowcaseCarouselDelegate {
//    func didLayoutItems()
//    func didTapItem(at position: Int)
//}
//
//final class ShowcaseCarousel: UIViewController {
//    private var images: [UIImageView]
//    private var delegate: ShowcaseCarouselDelegate
//    
//    private lazy var carousel: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .horizontal
//        
//        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        collection.delegate = self
//        collection.dataSource = self
//        collection.showsHorizontalScrollIndicator = false
//        collection.isUserInteractionEnabled = true
//        collection.isAccessibilityElement = true
//        collection.register(
//            ShowcaseCell.self,
//            forCellWithReuseIdentifier: ShowcaseCell.identifier)
//        return collection
//    }()
//    
//    init(images: [UIImageView], delegate: ShowcaseCarouselDelegate) {
//        self.images = images
//        self.delegate = delegate
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//}
//
//extension ShowcaseCarousel: UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        images.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(
//            withReuseIdentifier: ShowcaseCell.identifier,
//            for: indexPath) as? ShowcaseCell
//        cell?.addBanner()
//    }
//
//    private getItemFor(indexPath: IndexPath) {
//        guard let item =
//    }
//}
//
//extension ShowcaseCarousel: UICollectionViewDelegate {
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        Sentinel.info("indexPath: \(indexPath)")
//        delegate.didTapItem(at: indexPath.row)
//    }
//}
