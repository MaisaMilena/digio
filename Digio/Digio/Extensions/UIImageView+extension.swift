import UIKit
import Foundation
import SnapKit

extension UIImageView {
    func setImage(url: URL) {
        URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            if let data = data {
                DispatchQueue.main.async {
                    self?.image = UIImage(data: data)
                }
            }
        }
        .resume()
    }
}
