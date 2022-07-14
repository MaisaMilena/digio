import XCTest
@testable import Digio

final class InteractorTests: XCTest {
    private lazy var service = ServiceStub()
    private lazy var presenter =  PresenterSpy()
    private lazy var sut: InteractorProtocol = Interactor(presenter: presenter, service: service)

    func testFetch_WhenIsSuccess_ShouldCallPresenter() {
        service.stubResponse(ServiceMock.success)
        sut.fetch()
        XCTAssertEqual(service.fetchCount, 1)
        XCTAssertEqual(presenter.showCount, 1)
    }

    func testFetch_WhenIsFailure_ShouldCallPresenter() {
        service.stubError(.urlNotFound)
        sut.fetch()
        XCTAssertEqual(service.fetchCount, 1)
        XCTAssertEqual(presenter.showCount, 1)
    }
}
