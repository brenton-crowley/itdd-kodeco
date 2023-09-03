/// Copyright (c) 2021 Razeware LLC
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

class CashRegister {
  
    var availableFunds: Double
    
    var transactionTotal: Double { transactions.reduce(0 , +) }
    
    private var transactions: [Double] = []
    
    init(availableFunds: Double = 0.0) {
        self.availableFunds = availableFunds
    }
    
    func addItem(_ item: Double) {
        transactions.append(item)
    }
    
    func acceptCashPayment(_ cash: Double) {
        availableFunds -= cash
    }
}

// You’ll almost always subclass XCTestCase to create your test classes.
class CashRegisterTests: XCTestCase {
    
    // Set up instance variable for tests to reduce code duplication
    var availableFunds: Double!
    var sut: CashRegister!
    var itemCost: Double!
    
    // Common tasks to set up each test
    override func setUp() {
        super.setUp()
        
        availableFunds = 100.0
        sut = CashRegister(availableFunds: 100.0)
        itemCost = 42.0
    }
    
    // Clean up after each test
    override func tearDown() {
        
        availableFunds = nil
        sut = nil
        itemCost = nil
        
        super.tearDown()
    }
    
    // XCTest requires all test methods begin with the keyword test to be run
    // Next, describe what’s being tested. Here, this is init.
    // There’s then an underscore to seprate it from the next part.
    
    // Write an initializer that accepts availableFunds.
    func testInit_acceptsAvailableFunds() {
        
        // When
        let sut = CashRegister(availableFunds: availableFunds)
        
        // Then
        XCTAssertEqual(availableFunds, sut.availableFunds)
    }
    
    // Write a method for addItem that adds to a transaction.
    func testAddItem_oneItem() {
        
        // When
        sut.addItem(itemCost)
        
        // Then
        XCTAssertEqual(sut.transactionTotal, itemCost)
        
    }
    
    func testAddItem_twoItems() {
        
        let itemCost2 = 20.0
        let expectedTotal = itemCost + itemCost2
        
        sut.addItem(itemCost)
        sut.addItem(itemCost2)
        
        XCTAssertEqual(sut.transactionTotal, expectedTotal)
        
    }
    
    func testAcceptsCashPayment() {
        
        let expectedTotal = itemCost
        
        sut.addItem(itemCost)
        sut.acceptCashPayment(itemCost)
        
        XCTAssertEqual(sut.transactionTotal, expectedTotal)
    }
    
    func testAcceptsCashPayment_addsPaymentToAvailableFunds() {
        
        let expectedAvailableFunds = sut.availableFunds - itemCost
        
        sut.addItem(itemCost)
        sut.acceptCashPayment(itemCost)
        
        XCTAssertEqual(sut.availableFunds, expectedAvailableFunds)
    }
}

// This tells the playground to run the test methods defined within CashRegisterTests.
CashRegisterTests.defaultTestSuite.run()
