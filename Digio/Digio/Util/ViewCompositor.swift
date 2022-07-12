import UIKit

enum ViewCompositor {
    // Not working :(
    static func addShadow(for image: ShadowBorder) {
        let size = CGSize(width: image.frame.width, height: image.frame.height)
        let rect = CGRect(origin: CGPoint(x: 0, y: 0), size: size)
        let container = UIView(frame: rect)
        container.layer.shadowColor = UIColor.black.cgColor
        container.layer.shadowOpacity = image.opacity
        container.layer.shadowRadius = image.radius
        container.layer.shadowOffset = .zero
        container.layer.shadowPath = UIBezierPath(rect: image.bounds).cgPath
        container.layer.shouldRasterize = true
        container.layer.rasterizationScale = UIScreen.main.scale
        image.addSubview(container)
        return
    }
    
    static func addBorder(for image: RoundedBorder) {
        image.clipsToBounds = true
        image.layer.cornerRadius = image.style.rawValue
    }
}
