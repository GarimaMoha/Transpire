import XCTest

final class SearchScreen {
    
    private enum Identifier {
        static let skipButton = "Skip"
        static let tabBar = "Tab Bar"
        static let searchTab = "Search"
        static let searchField = "Search Wikipedia"
        static let historyTab = "History"
        static let UnitedStates = "United States"
        static let articleCell = "ArticleCell"
        static let backButtonLabel = "W"
        static let cancelButton = "Cancel"
    }
    
    private let app = XCUIApplication()
    private lazy var skipButton = app.buttons[Identifier.skipButton].firstMatch
    
    func navigateToSearchTab() -> Bool {
        let searchTab = app
            .tabBars[Identifier.tabBar]
            .buttons[Identifier.searchTab]

        if searchTab.exists() {
            searchTab.tap()
            return true
        }
        
        return false
    }
    
    func navigateToHistoryTab() -> Bool {
        let historyTab = app
            .tabBars[Identifier.tabBar]
            .buttons[Identifier.historyTab]

        if historyTab.exists() {
            historyTab.tap()
            return true
        }
        
        return false
    }
    
    func checkfirstUserLogin() -> Bool {
        return skipButton.waitTillExists()
    }
    
    func tapSkipButton() -> Bool {
        if skipButton.exists() {
            skipButton.tap()
            return true
        }
        return false
    }
    
    func search(text: String) -> Bool {
        let searchfield = app.searchFields[Identifier.searchField].firstMatch
        if searchfield.exists() {
            searchfield.tap()
            searchfield.typeText(text)
            return true
        }
        return false
    }
    
    func tapSearchResult(with text: String) -> Bool {
        let cell = app
            .descendants(matching: .collectionView)
            .cells[Identifier.articleCell]
            .staticTexts[text]
            .firstMatch
        
        let cellExists = cell.waitTillExists()
        if cellExists {
            cell.tap()
            return true
        }
        return false
    }
     
    func checkHistoryCells(for result: String) -> Bool {
        let collectionView = app.collectionViews
        let cell = collectionView.cells.otherElements.containing(.staticText, identifier: result).element
        if cell.exists() {
            cell.tap()
            return true
        }
        return false
    }
    
    
    func checkWebContentLoaded(for result: String) -> Bool {
        let webContent = app.descendants(matching: .staticText)[result]
        return webContent.waitTillExists()
    }
    
    func tapWebViewBackButton() -> Bool {
        let backButton = app.descendants(matching: .button)[Identifier.backButtonLabel].firstMatch
        let backButtonExists = backButton.waitTillExists()
        
        if backButtonExists {
            backButton.tap()
            return true
        }
        
        return false
    }
    
    func tapCancelButtonOnSearchTab() -> Bool {
        let cancelButton = app.descendants(matching: .button)[Identifier.cancelButton]
        if cancelButton.exists() {
            cancelButton.tap()
            return true
        }
        return false
    }
}

private extension XCUIElement {
    func waitTillExists(timeOut: TimeInterval = 5.0) -> Bool {
        return waitForExistence(timeout: timeOut)
    }
    
    func exists() -> Bool {
        return exists && isHittable
    }
}
