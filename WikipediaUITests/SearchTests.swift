import XCTest

final class SearchTests: XCTestCase {
    
    private lazy var searchScreen = SearchScreen()
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        XCUIApplication().launch()
    }
    
    func testSearchFlow() {
        if searchScreen.checkfirstUserLogin() {
            XCTAssertTrue(searchScreen.tapSkipButton())
            performSearchFlow()
        } else {
            performSearchFlow()
        }
    }
    
    private func performSearchFlow() {
        XCTAssertTrue(searchScreen.navigateToSearchTab())
        XCTAssertTrue(searchScreen.search(text: "america"))
        XCTAssertTrue(searchScreen.tapSearchResult(with: "United States"))
        XCTAssertTrue(searchScreen.checkWebContentLoaded(for: "United States"))
        XCTAssertTrue(searchScreen.tapWebViewBackButton())
        XCTAssertTrue(searchScreen.tapCancelButtonOnSearchTab())
        XCTAssertTrue(searchScreen.navigateToHistoryTab())
        XCTAssertTrue(searchScreen.checkHistoryCells(for: "United States"))
        XCTAssertTrue(searchScreen.checkWebContentLoaded(for: "United States"))
    }
}
