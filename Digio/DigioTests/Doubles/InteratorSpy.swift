import Digio

final class InteractorSpy: InteractorProtocol {
    private(set) var fetchCount = 0

    func fetch() {
        fetchCount += 1
    }
}
