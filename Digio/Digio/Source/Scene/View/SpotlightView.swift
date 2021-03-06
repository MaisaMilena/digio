import UIKit
import SnapKit

extension SpotlightView.Layout {
    static let height: CGFloat = 180
    static let width: CGFloat = height * 2.1
    static let opacity: Float = 0.4
}

public final class SpotlightView: UIImageView {
    enum Layout {}
    private lazy var borderStyle = ImageBorderStyle.light
    private lazy var shadowOpacity = Layout.opacity
    private lazy var shadowRadius = borderStyle.rawValue
    
    init(model: ImagePresentationViewModel) {
        super.init(frame: .zero)
        contentMode = .scaleToFill
        setupImage(placeholder: model.placeholder, url: model.url)
        setupInteraction(title: model.title)
        setupConstraints()
        roundBorder()
        addShadow()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupInteraction(title: String) {
        isUserInteractionEnabled = false
        isAccessibilityElement = true
        accessibilityValue = title
        accessibilityTraits = .button
    }
    
    private func setupImage(placeholder: UIImage, url: URL?) {
        guard let url = url else {
            image = placeholder
            return
        }
        setImage(url: url)
    }
    
    private func setupConstraints() {
        self.snp.makeConstraints {
            $0.width.equalTo(Layout.width)
            $0.height.equalTo(Layout.height)
        }
    }
}

// MARK: Style Extensions
extension SpotlightView: RoundedBorder {
    var style: ImageBorderStyle {
        get { return self.borderStyle }
        set { self.borderStyle = newValue }
    }
    
    func roundBorder() {
        ViewCompositor.addBorder(for: self)
    }
}
                            
extension SpotlightView: ShadowBorder {
    var opacity: Float {
        get { return self.shadowOpacity }
        set { self.shadowOpacity = newValue }
    }
    
    var radius: CGFloat {
        get { return self.shadowRadius }
        set { self.shadowRadius = newValue }
    }
    
    func addShadow() {
        ViewCompositor.addShadow(for: self)
    }
}
