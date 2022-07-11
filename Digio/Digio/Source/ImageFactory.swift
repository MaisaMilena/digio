import Foundation
import UIKit

protocol ImageFactoryProtocol {
    typealias BannerStyle = UIImageView & ShadowBorder & RoundedBorder
    static func make(_ model: ImagePresentationViewModel) -> UIImageView
}

protocol RoundedBorder: UIView {
    var style: ImageBorderStyle { get set }
    func roundBorder()
}

protocol ShadowBorder: UIView {
    var opacity: Float { get set }
    var radius: CGFloat { get set }
    func addShadow()
}

enum ImageBorderStyle: CGFloat {
    case light = 20
    case heavy = 40
}

// MARK: Factory implementation
enum SpotlightFactory: ImageFactoryProtocol {
    static func make(_ model: ImagePresentationViewModel) -> UIImageView {
        SpotlightView(model: model)
    }
}
