//
//  OutletTest.swift
//  UseCaseSprintTests
//
//  Created by Capgemini-DA322 on 9/14/22.
//

import XCTest
@testable import UseCaseSprint

class OutletTest: XCTestCase {
    
    var signup: SignUpViewController!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        signup = storyboard.instantiateViewController(withIdentifier: "signVC") as? SignUpViewController
        signup.loadView()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testOutletTextFeild(){
        XCTAssertNotNil(signup.nameTxtFld, "Not connected")
        XCTAssertNotNil(signup.emailTextFld, "not Connected")
    }
    
    func testOuletTextFieldKeyboard(){
        XCTAssertEqual(signup.emailTextFld.keyboardType, UIKeyboardType.emailAddress, "Not email type keyboard")
        XCTAssertEqual(signup.mobileTxtFld.keyboardType, UIKeyboardType.phonePad)
    }
    
    func testOutletButton() throws{
        let signbutton = try XCTUnwrap(signup.signupButton, "Button not connected")
        let checkaction = try XCTUnwrap(signbutton.actions(forTarget: signup, forControlEvent: .touchUpInside), "Action not performed")
        XCTAssertEqual(checkaction.first, "signUpButtonClicked:", "Action is having same name?")
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
