//
//  RecipleaseTests.swift
//  RecipleaseTests
//
//  Created by Adam Mabrouki on 08/12/2020.
//


//
import XCTest
@testable import Reciplease

class RecipleaseTests: XCTestCase {
    
    func testGetRecipes_WhenNoDataIsPassed_ThenShouldReturnFailedCallback() {
        let session = FakeSession(fakeResponse: FakeResponse(response: nil, data: nil))
        let requestService = RequestService(session: session)
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        requestService.getData(q: ["potatoe"].joined()) { result in
            guard case .failure(let error) = result else {
                XCTFail("Test getData method with no data failed.")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetRecipes_WhenIncorrectResponseIsPassed_ThenShouldReturnFailedCallback() {
        let session = FakeSession(fakeResponse: FakeResponse(response: FakeResponseData.responseKO, data: FakeResponseData.correctData))
        let requestService = RequestService(session: session)
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        requestService.getData(q: ["potatoe"].joined()) { result in
            guard case .failure(let error) = result else {
                XCTFail("Test getData method with incorrect response failed.")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetRecipes_WhenUndecodableDataIsPassed_ThenShouldReturnFailedCallback() {
        let session = FakeSession(fakeResponse: FakeResponse(response: FakeResponseData.responseOK, data: FakeResponseData.incorrectData))
        let requestService = RequestService(session: session)
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        requestService.getData(q: ["potatoe"].joined()) { result in
            guard case .failure(let error) = result else {
                XCTFail("Test getData method with undecodable data failed.")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetRecipes_WhenCorrectDataIsPassed_ThenShouldReturnSuccededCallback() {
        let session = FakeSession(fakeResponse: FakeResponse(response: FakeResponseData.responseOK, data: FakeResponseData.correctData))
        let requestService = RequestService(session: session)
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        requestService.getData(q: ["potatoe"].joined()) { result in
            guard case .success(let data) = result else {
                XCTFail("Test getData method with undecodable data failed.")
                return
            }
            XCTAssertTrue(data.hits[0].recipe.label == "Potatoe & Chipotle Tacos")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
}

