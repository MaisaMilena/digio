import UIKit

enum ViewCompositor {
    static func addShadow(for image: ShadowBorder) {
        image.layer.shadowColor = UIColor.black.cgColor
        image.layer.shadowOpacity = image.opacity
        image.layer.shadowRadius = image.radius
        image.layer.shadowPath = UIBezierPath(rect: image.bounds).cgPath
        image.layer.shouldRasterize = true
        image.layer.rasterizationScale = UIScreen.main.scale
        return
    }
    
    static func addBorder(for image: RoundedBorder) {
        image.layer.cornerRadius = image.style.rawValue
    }
}
