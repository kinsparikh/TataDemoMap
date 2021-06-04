//
//  TataMapDemoTests.swift
//  TataMapDemoTests
//
//  Created by Kayaan on 04/06/21.
//  Copyright © 2021 Abhilash Mathur. All rights reserved.
//

import XCTest
@testable import TataMapDemo

class TataMapDemoTests: XCTestCase {
    var mapViewModel:MapsViewModel!
    var sut: URLSession!
    override func setUpWithError() throws {
        sut = URLSession(configuration: .default)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        sut = nil
          try super.tearDownWithError()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
    
   
    // Asynchronous test: success fast, failure slow
    func testValidApiCallGetsHTTPStatusCode200() throws {
      // given
      let urlString =
        "http://www.rando.com/api/v1.0/random?min=0&max=100&count=1"
      let url = URL(string: urlString)!
      // 1
      let promise = expectation(description: "Status code: 200")

      // when
      let dataTask = sut.dataTask(with: url) { _, response, error in
        // then
        if let error = error {
          XCTFail("Error: \(error.localizedDescription)")
          return
        } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
          if statusCode == 200 {
            // 2
            promise.fulfill()
          } else {
            XCTFail("Status code: \(statusCode)")
          }
        }
      }
      dataTask.resume()
      // 3
      wait(for: [promise], timeout: 5)
    }

}
//let url = URL(string: "http://www.randomnumberapi.com/test")!
