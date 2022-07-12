import UIKit

public protocol ViewControlerDisplayProtocol: AnyObject {
    func showHighlights(views: [ImagePresentationViewModel])
}

class ViewController: UIViewController {
    private var interactor: InteractorProtocol
    private var carouselHighlight: ShowcaseProtocol?
    
    init(interactor: InteractorProtocol) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        interactor.fetch()
    }
    
    private func setupCarousel() {
        carouselHighlight = ShowcaseCarousel(delegate: self)
        if let carouselHighlight = carouselHighlight {
            view.addSubview(carouselHighlight.carousel)
        }
    }
    
    private func setupContraints() {
        if let carouselHighlight = carouselHighlight?.carousel {
            carouselHighlight.snp.makeConstraints {
                $0.topMargin.equalTo(view.safeAreaInsets.top)
                $0.leading.trailing.equalToSuperview()
            }
        }
    }
}

extension ViewController: ViewControlerDisplayProtocol {
    func showHighlights(views: [ImagePresentationViewModel]) {
        DispatchQueue.main.async {
            self.setupCarousel()
            self.carouselHighlight?.layout(viewModels: views)
            self.setupContraints()
        }
    }
}

extension ViewController: ShowcaseCarouselDelegate {
    func didLayoutItems() {
        Sentinel.info("")
    }
    
    func didTapItem(at position: Int) {
        Sentinel.info("")
    }
}
