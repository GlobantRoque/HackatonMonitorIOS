import XCTest
@testable import APIStatusMonitor

class MainViewModelTests: XCTestCase {
    
    var viewModel: MainViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = MainViewModel()
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testLoadEndpoints() {
        let mockEndpoints = [
            Endpoint(name: "Service 1", url: "https://service1.com", isActive: true),
            Endpoint(name: "Service 2", url: "https://service2.com", isActive: false)
        ]
        
        let expectation = XCTestExpectation(description: "Endpoints loaded")
        
        let mockService = MockEndpointService(endpoints: mockEndpoints)
        viewModel.endpointService = mockService
        viewModel.loadEndpoints()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertEqual(self.viewModel.endpoints.count, mockEndpoints.count)
            XCTAssertEqual(self.viewModel.endpoints[0].name, mockEndpoints[0].name)
            XCTAssertEqual(self.viewModel.endpoints[1].name, mockEndpoints[1].name)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2)
    }

    
    func testScheduleUpdate() {
        let mockService = MockEndpointService()
        viewModel.endpointService = mockService
        viewModel.scheduleUpdate()
        XCTAssertNotNil(viewModel.timer)
    }
    
    func testScheduleNextUpdate() {
        viewModel.scheduleNextUpdate()
        XCTAssertFalse(viewModel.nextUpdate.isEmpty)
    }
}
