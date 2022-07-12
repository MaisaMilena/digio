import UIKit

public protocol PresenterProtocol: AnyObject {
    func show(data: HomeData)
}

final class Presenter {
    private let coordinator: CoordinatorProtocol
    var viewController: ViewControlerDisplayProtocol?
    
    init(coordinator: CoordinatorProtocol) {
        self.coordinator = coordinator
    }
}

extension Presenter: PresenterProtocol {
    func show(data: HomeData) {
        viewController?.showHighlights(views: parseHomeDataToViewModel(data))
    }
    
    private func parseHomeDataToViewModel(_ rawData: HomeData) -> [ImagePresentationViewModel] {
        rawData.spotlight.map {
            ImagePresentationViewModel(
                placeholder: UIImage(),
                url: URL(string: $0.bannerURL),
                title: $0.name,
                description: $0.spotlightDescription
            )
        }
    }
}
