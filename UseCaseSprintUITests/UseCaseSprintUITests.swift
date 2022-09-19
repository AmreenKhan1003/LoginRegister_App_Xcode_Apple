//
//  UseCaseSprintUITests.swift
//  UseCaseSprintUITests
//
//  Created by Capgemini-DA322 on 9/14/22.
//

import XCTest

class UseCaseSprintUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        //Sign up
        app.buttons["SignUp"].tap()
        XCTAssert(app.navigationBars["Sign Up"].exists, "Sign up page doesnt exixt")
        app.navigationBars["Sign Up"].buttons["Login"].tap()
        
        app.buttons["Login"].tap()
        XCTAssert(app.navigationBars["Employees"].exists, "Emloyees page doesnt exist")
        
        app.tables/*@START_MENU_TOKEN@*/.staticTexts["Amreen Khan"]/*[[".cells.staticTexts[\"Amreen Khan\"]",".staticTexts[\"Amreen Khan\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.navigationBars["Login"].buttons["Employees"].tap()
        
        
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testforgotpassword(){
        let app = XCUIApplication()
        app.launch()
        let forgot = app.staticTexts["forgot password"]
        forgot.tap()
    }
    
    //func testLoginButton() throws
    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
                
                
                let app = XCUIApplication()
                app/*@START_MENU_TOKEN@*/.buttons["Clear text"]/*[[".textFields[\"Email ID\"].buttons[\"Clear text\"]",".buttons[\"Clear text\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
                
                let forgotPasswordStaticText = app/*@START_MENU_TOKEN@*/.staticTexts["forgot password"]/*[[".buttons[\"forgot password\"].staticTexts[\"forgot password\"]",".staticTexts[\"forgot password\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
                forgotPasswordStaticText.tap()
                app.navigationBars["Login"].buttons["Login"].tap()
                app.textFields["Email ID"].tap()
                forgotPasswordStaticText.tap()
                                
                
                                                                                
                
                
            }
        }
    }
}
