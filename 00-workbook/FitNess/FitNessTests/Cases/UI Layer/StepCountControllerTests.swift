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

final class StepCountControllerTests: XCTestCase {
  
  var sut: StepCountController!
  
  override func setUpWithError() throws {
    try super.setUpWithError()
    let rootController = getRootViewController()
    sut = rootController.stepController
  }
  
  override func tearDownWithError() throws {
    
      AppModel.instance.restart()
      sut.updateUI()
      try super.tearDownWithError()
  }

  // MARK: - Given
  func givenGoalSet() {
    AppModel.instance.dataModel.goal = 1000
  }
  
  func givenInProgress() {
    givenGoalSet()
    sut.startStopPause(nil)
  }

  
  // MARK: - When Methods
  private func whenStartStopPause() {
    sut.startStopPause(nil)
  }
  
  // MARK: - Initial State
  
  func testController_whenCreated_buttonLabelIsStart() {
    
    // given
    
    let text = sut.startButton.title(for: .normal)
    
    XCTAssertEqual(text, AppState.notStarted.nextStateButtonLabel)
  }
  
  // MARK: - In Progress
  
  func testController_whenStartTapped_appIsInProgressState() {
    
    givenGoalSet()
    
    whenStartStopPause()
    
    let state = AppModel.instance.appState
    
    XCTAssertEqual(state, AppState.inProgress)
    
  }
  
  func testController_whenStartTapped_buttonLabelIsPause() {
    
    // Given
    givenGoalSet()
    
    // When
    whenStartStopPause()
    
    // Then
    let text = sut.startButton.title(for: .normal)
    
    XCTAssertEqual(text, AppState.inProgress.nextStateButtonLabel) //Don't hard code the string
  }

  // MARK: - Goal
  func testDataModel_whenGoalUpdate_updatesToNewGoal() {
    
    // Given
    
    // When
    sut.updateGoal(newGoal: 50)
    
    // Then
    XCTAssertEqual(AppModel.instance.dataModel.goal, 50)
  }
  
  
  
  // MARK: - ChaseView
  
  func testChaseView_whenLoaded_isNotStarted() {
    
    let chaseView = sut.chaseView
    // Then
    XCTAssertEqual(chaseView?.state, .notStarted)
  }
  
  func testChaseView_whenInProgress_viewIsInProgress() {
    
    // Given
    givenInProgress()
    
    let chaseView = sut.chaseView
    XCTAssertEqual(chaseView?.state, .inProgress)
  }
}
