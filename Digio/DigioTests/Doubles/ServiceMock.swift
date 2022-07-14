import Digio
import Foundation

enum ServiceMock {
    static let success = HomeData(
        spotlight: [
            Spotlight(name: "Star Trek Voyager", bannerURL: "www.voyager.com", spotlightDescription: "must watch")
        ],
        products: [
            Product(name: "phaser", imageURL: "www.phaser.com", productDescription: "so protective")
        ],
        cash: Cash(title: "tricorder", bannerURL: "www.tricorder.com", cashDescription: "very much health")
    )
}
