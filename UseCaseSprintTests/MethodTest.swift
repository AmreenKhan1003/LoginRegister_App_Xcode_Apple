//
//  MethodTest.swift
//  UseCaseSprintTests
//
//  Created by Capgemini-DA322 on 9/14/22.
//

import XCTest
@testable import UseCaseSprint

class MethodTest: XCTestCase {
    
    var signupvc: SignUpViewController!
    var keychain: KeyChainManager!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        signupvc = storyboard.instantiateViewController(withIdentifier: "signVC") as? SignUpViewController
        signupvc.loadView()
        
    }
    
    func testNameField(){
        let name = "Amreen"
        XCTAssertTrue(signupvc.isValidName(name: name), "Name not valid")
    }
    func testEmailField(){
        let email = "amreen@mail.com"
        XCTAssertTrue(signupvc.isValidEmailID(email: email), "Email not valid")
    }
    
    func testAlert(){
        let titles = "test"
        XCTAssert(signupvc.callAlert(titles: titles), "Alert failed")
    }
    
    func testKeyChain(){
        let namedata = Data("Amreen".utf8)
        XCTAssert(KeyChainManager.save(name: namedata, email: "mmm@mail.com", password: "Amreen@786"), "cant save keychain")
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
