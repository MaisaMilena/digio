import Foundation
import UIKit

public struct ImagePresentationViewModel {
    var placeholder: UIImage
    var url: URL?
    var title: String
    var description: String
}

extension ImagePresentationViewModel: Equatable {
    public static func == (
        lhs: ImagePresentationViewModel,
        rhs: ImagePresentationViewModel
    ) -> Bool {
        lhs.url == rhs.url &&
        lhs.title == rhs.title &&
        lhs.description == rhs.description
    }
}
