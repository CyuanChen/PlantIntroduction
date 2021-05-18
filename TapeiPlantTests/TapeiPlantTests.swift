//
//  TapeiPlantTests.swift
//  TapeiPlantTests
//
//  Created by Peter Chen on 2021/5/19.
//

import XCTest
import TapeiPlant


class TapeiPlantTests: XCTestCase {
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAPI() {
        var statusCode: Int?
        var responseError: Error?
        let url = URL(string: "https://data.taipei/opendata/datalist/apiAccess?scope=resourceAquire&rid=f18de02f-b6c9-47c0-8cda-50efad621c14&limit=20&offset=1")
        let promise = expectation(description: "Invalid status code.")
        let dataTask = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            statusCode = (response as? HTTPURLResponse)?.statusCode
            responseError = error
            promise.fulfill()
        }
        dataTask.resume()
        wait(for: [promise], timeout: 5)
        XCTAssertNil(responseError, "Response is error")
        XCTAssertEqual(statusCode, 200, "Invalid status code")
    }

}
