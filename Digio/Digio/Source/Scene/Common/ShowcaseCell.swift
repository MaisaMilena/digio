import UIKit

final class ShowcaseCell: UICollectionViewCell {
    static let identifier: String = "showcaseCell"
    
    func addBanner(_ banner: UIImageView) {
        addSubview(banner)
        banner.snp.makeConstraints {
            $0.margins.equalToSuperview()
        }
    }
}
