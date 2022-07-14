import Foundation

// MARK: - HomeData
public struct HomeData: Decodable {
    let spotlight: [Spotlight]
    let products: [Product]
    let cash: Cash
    
    public init(spotlight: [Spotlight] = [], products: [Product] = [], cash: Cash = Cash()) {
        self.spotlight = spotlight
        self.products = products
        self.cash = cash
    }
}

// MARK: - Cash
public struct Cash: Decodable {
    let title: String
    let bannerURL: String
    let cashDescription: String

    enum CodingKeys: String, CodingKey {
        case title, bannerURL
        case cashDescription = "description"
    }
    
    public init(title: String = "", bannerURL: String = "", cashDescription: String = "") {
        self.title = title
        self.bannerURL = bannerURL
        self.cashDescription = cashDescription
    }
}

// MARK: - Product
public struct Product: Decodable {
    let name: String
    let imageURL: String
    let productDescription: String

    enum CodingKeys: String, CodingKey {
        case name, imageURL
        case productDescription = "description"
    }
    
    public init(name: String = "", imageURL: String = "", productDescription: String = "") {
        self.name = name
        self.imageURL = imageURL
        self.productDescription = productDescription
    }
}

// MARK: - Spotlight
public struct Spotlight: Decodable {
    let name: String
    let bannerURL: String
    let spotlightDescription: String

    enum CodingKeys: String, CodingKey {
        case name, bannerURL
        case spotlightDescription = "description"
    }
    
    public init(name: String = "", bannerURL: String = "", spotlightDescription: String = "") {
        self.name = name
        self.bannerURL = bannerURL
        self.spotlightDescription = spotlightDescription
    }
}
