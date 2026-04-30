import XCTest

class ScreenshotTests: XCTestCase {
    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        app = XCUIApplication()
        app.launchArguments = ["--uitesting"]
        app.launchEnvironment = ["DYLD_INSERT_LIBRARIES": ""]
        app.launch()
        Thread.sleep(forTimeInterval: 3.0)
    }

    private func captureScreenshot(name: String) {
        let window = app.windows.firstMatch
        let screenshot = window.screenshot()
        let attachment = XCTAttachment(screenshot: screenshot)
        attachment.name = name
        attachment.lifetime = .keepAlways
        add(attachment)
    }

    private func tapTab(index: Int) {
        let tabBar = app.tabBars.buttons
        if tabBar.count > index {
            tabBar.allElementsBoundByIndex[index].tap()
            Thread.sleep(forTimeInterval: 2.0)
        }
    }

    func test01_CaptureHomeTab() throws {
        captureScreenshot(name: "01_Home")
    }

    func test02_CaptureCatsTab() throws {
        tapTab(index: 1)
        captureScreenshot(name: "02_Cats")
    }

    func test03_CaptureTasksTab() throws {
        tapTab(index: 2)
        captureScreenshot(name: "03_Tasks")
    }

    func test04_CaptureLearnTab() throws {
        tapTab(index: 3)
        captureScreenshot(name: "04_Learn")
    }

    func test05_CaptureProfileTab() throws {
        tapTab(index: 4)
        captureScreenshot(name: "05_Profile")
    }
}