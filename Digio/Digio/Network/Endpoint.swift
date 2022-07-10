import Foundation

public protocol ApiEndpoint {
    var path: String { get }
    var method: HTTPMethod { get }
}

extension ApiEndpoint {
    func getURL() -> URL? {
        URL(string: path)
    }
}

struct Endpoint: ApiEndpoint {
    var path: String = "https://7hgi9vtkdc.execute-api.sa-east-1.amazonaws.com/sandbox/products"
    var method: HTTPMethod = .get
}
