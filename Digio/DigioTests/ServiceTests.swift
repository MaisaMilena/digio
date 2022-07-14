import XCTest
@testable import Digio

final class ServiceTests: XCTest {
    private lazy var sut = ServiceStub()

    func testService_WhenIsSuccess_ShouldReturnSuccess() {
        sut.stubResponse(ServiceMock.success)
        sut.fetch { result in
            switch result {
                case let .success(data):
                    XCTAssertNotNil(data)
                case .failure:
                    XCTFail()
            }
        }
    }

    func testService_WhenIsInternetConnectError_ShouldResultFailure() {
        sut.stubError(.internetConection)
        sut.fetch { result in
            switch result {
                case .success:
                    XCTFail()
                case let .failure(error):
                    XCTAssertEqual(error, APIError.internetConection)
            }
        }
    }
    
    func testService_WhenIsDecodeError_ShouldResultFailure() {
        sut.stubError(.decode)
        sut.fetch { result in
            switch result {
                case .success:
                    XCTFail()
                case let .failure(error):
                    XCTAssertEqual(error, APIError.decode)
            }
        }
    }
    
    func testService_WhenIsURLNotFoundError_ShouldResultFailure() {
        sut.stubError(.urlNotFound)
        sut.fetch { result in
            switch result {
                case .success:
                    XCTFail()
                case let .failure(error):
                    XCTAssertEqual(error, APIError.decode)
            }
        }
    }
}
