@testable import Digio

final class PresenterSpy: PresenterProtocol {
    private(set) var showCount = 0
    
    func show(data: HomeData) {
        showCount += 1
    }
}
