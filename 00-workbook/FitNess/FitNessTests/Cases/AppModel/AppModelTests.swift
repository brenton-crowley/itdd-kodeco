/// Copyright (c) 2023 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import XCTest
@testable import FitNess

final class AppModelTests: XCTestCase {
  
  // This variable sets aside storage for an AppModel to use in the tests. It’s force-unwrapped in this case because you don’t have access to the class initializer. Instead, you have to set up variables later, for example, in setUpWithError().
  var sut: AppModel!
  
  override func setUpWithError() throws {
    try super.setUpWithError()
    
    sut = AppModel()
  }
  
  override func tearDownWithError() throws {
    sut = nil
    try super.tearDownWithError()
  }
  
  // MARK: - Given
  func givenGoalSet() {
    sut.dataModel.goal = 1000
  }
  
  func givenInProgress() {
    givenGoalSet()
    try! sut.start()
  }

  
  //  1. The app should start in .notStarted to let the UI render the welcome messaging.
  func testAppModel_whenInitialised_isInNotStartedState() {
    
    let initialState = sut.appState
    
    XCTAssertEqual(initialState, AppState.notStarted)
    
  }
  
  func testAppModel_whenStarted_throwsError() {
    
    XCTAssertThrowsError(try sut.start())
  }
  
  func testState_withGoalSet_doesNotThrow() {
    
    // Given
    givenGoalSet()
    
    // When
    
    // Then
    XCTAssertNoThrow(try sut.start())
  }
  
  //  2. When the user taps Start, the app should move into .inProgress to track user activity and display updates.
  func testAppModel_whenStarted_isInProgressState() {
    
    // Given
    givenGoalSet()
    
    // When
    try? sut.start()
    
    //Then
    let observedState = sut.appState
    XCTAssertEqual(observedState, .inProgress)
    
  }
  
  // MARK: - Restart
  func testAppModel_whenReset_isInNotStartedState() {
    // given
    givenInProgress()

    // when
    sut.restart()

    // then
    XCTAssertEqual(sut.appState, .notStarted)
  }

  func testAppModel_whenReset_goalIsNil() {
    
    // Given
    givenInProgress()
    
    // When
    sut.restart()
    
    // Then
    XCTAssertTrue(sut.dataModel.goal == nil)
  }
  
}
