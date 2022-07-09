// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let homeData = try? newJSONDecoder().decode(HomeData.self, from: jsonData)

//
// To read values from URLs:
//
//   let task = URLSession.shared.homeDataTask(with: url) { homeData, response, error in
//     if let homeData = homeData {
//       ...
//     }
//   }
//   task.resume()

import Foundation

// MARK: - HomeData
struct HomeData: Codable {
    let spotlight: [Spotlight]
    let products: [Product]
    let cash: Cash
}

//
// To read values from URLs:
//
//   let task = URLSession.shared.cashTask(with: url) { cash, response, error in
//     if let cash = cash {
//       ...
//     }
//   }
//   task.resume()

// MARK: - Cash
struct Cash: Codable {
    let title: String
    let bannerURL: String
    let cashDescription: String

    enum CodingKeys: String, CodingKey {
        case title, bannerURL
        case cashDescription = "description"
    }
}

// MARK: - Product
struct Product: Codable {
    let name: String
    let imageURL: String
    let productDescription: String

    enum CodingKeys: String, CodingKey {
        case name, imageURL
        case productDescription = "description"
    }
}

// MARK: - Spotlight
struct Spotlight: Codable {
    let name: String
    let bannerURL: String
    let spotlightDescription: String

    enum CodingKeys: String, CodingKey {
        case name, bannerURL
        case spotlightDescription = "description"
    }
}

// MARK: - Helper functions for creating encoders and decoders

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    return decoder
}


// MARK: - URLSession response handlers

extension URLSession {
    fileprivate func codableTask<T: Codable>(with url: URL, completionHandler: @escaping (T?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completionHandler(nil, response, error)
                return
            }
            completionHandler(try? newJSONDecoder().decode(T.self, from: data), response, nil)
        }
    }

    func homeDataTask(with url: URL, completionHandler: @escaping (HomeData?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.codableTask(with: url, completionHandler: completionHandler)
    }
}
