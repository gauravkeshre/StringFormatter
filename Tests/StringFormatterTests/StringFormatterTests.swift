import XCTest
@testable import StringFormatter

class StringFormatterTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testExample() {
        let cardNumber = "123456789123456789078"
        let formatter = StringFormatter(regex: TextFormat.defaultCreditCard.regex)
        let final = formatter.format(string: cardNumber)
        XCTAssertEqual(final.fancy, "1234 5678 9123 456789078")
        XCTAssertEqual(final.normal, cardNumber)
    }
    
    func testPhoneNumber() {
        let phone = "8888888888"
        let format = TextFormat.custom("(+91) #### ##### #")
        let formatter = StringFormatter(regex: format.regex)
        let final = formatter.format(string: phone)
        XCTAssertEqual(final.fancy, "(+91) 8888 88888 8")
        XCTAssertEqual(final.normal, "8888888888")
    }
    
    func testPerformanceExample() {
        let phone = "8888888888"
        let format = TextFormat.custom("(+91) #### ##### #")
        let formatter = StringFormatter(regex: format.regex)
        
        self.measure {
            let _ = formatter.format(string: phone)
        }
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
