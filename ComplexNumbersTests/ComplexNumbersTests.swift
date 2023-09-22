//
//  ComplexNumbersTests.swift
//  ComplexNumbersTests
//
//  Created by Elijah on 9/22/23.
//

import XCTest
@testable import ComplexNumbers

class ComplexNumbersTests: XCTestCase {
    func testEquality() {
        XCTAssert(ComplexNumber(exactly: 0) == ComplexNumber(a: 0, b: 0))
        XCTAssert(ComplexNumber(exactly: 3) == ComplexNumber(a: 3, b: 0))
        XCTAssert(ComplexNumber(3) == ComplexNumber(a: 3, b: 0))
        XCTAssert(ComplexNumber(integerLiteral: 0) == ComplexNumber(a: 0, b: 0))
        XCTAssert(ComplexNumber(integerLiteral: 4) == ComplexNumber(a: 4, b: 0))
        XCTAssert(ComplexNumber(4) == ComplexNumber(a: 4, b: 0))
        XCTAssert(ComplexNumber(a: 0.0, b: 0.0) == ComplexNumber(a: 0, b: 0))
    }

    func testMagnitude() {
        XCTAssertEqual(ComplexNumber(a: 0, b: 0).magnitude, 0)
        XCTAssertEqual(ComplexNumber(a: 1, b: 0).magnitude, 1)
        XCTAssertEqual(ComplexNumber(a: 0, b: 1).magnitude, 1)
        XCTAssertEqual(ComplexNumber(a: 1, b: 1).magnitude, sqrt(2))
        XCTAssertEqual(ComplexNumber(a: -1, b: 1).magnitude, sqrt(2))
        XCTAssertEqual(ComplexNumber(a: 1, b: -1).magnitude, sqrt(2))
        XCTAssertEqual(ComplexNumber(a: -1, b: -1).magnitude, sqrt(2))
        XCTAssertEqual(ComplexNumber(a: 3, b: 4).magnitude, 5)
    }

    func testConjugate() {
        XCTAssertEqual(ComplexNumber(a: 0, b: 0).conjugate(), ComplexNumber(a: 0, b: 0))
        XCTAssertEqual(ComplexNumber(a: 3, b: 4).conjugate(), ComplexNumber(a: 3, b: -4))
        XCTAssertEqual(ComplexNumber(a: -3, b: -4).conjugate(), ComplexNumber(a: -3, b: 4))
        XCTAssertEqual(ComplexNumber(a: 3, b: -4).conjugate(), ComplexNumber(a: 3, b: 4))
        XCTAssertEqual(
            ComplexNumber(a: 3, b: 4).conjugate().magnitude,
            ComplexNumber(a: 3, b: 4).magnitude
        )
    }

    func testNagate() {
        var comp = ComplexNumber(a: 2, b: 7)
        comp.negate()
        XCTAssertEqual(comp, ComplexNumber(a: -2, b: -7))
        comp.negate()
        XCTAssertEqual(comp, ComplexNumber(a: 2, b: 7))
    }

    func testAddition() {
        let comp = ComplexNumber(a: 2, b: 7)
        let comp2 = ComplexNumber(a: 3, b: 12)
        let comp3 = ComplexNumber(a: -3, b: -12)
        let comp4 = ComplexNumber(a: 0.5, b: 3.4)
        XCTAssertEqual(comp + comp2, ComplexNumber(a: 5, b: 19))
        XCTAssertEqual(comp + comp3, ComplexNumber(a: -1, b: -5))
        XCTAssertEqual(comp + comp4, ComplexNumber(a: 2.5, b: 10.4))

        var comp5 = ComplexNumber(a: 4, b: 9)
        comp5 += comp2
        XCTAssertEqual(comp5, ComplexNumber(a: 7, b: 21))
    }

    func testSubtraction() {
        let comp = ComplexNumber(a: 2, b: 7)
        let comp2 = ComplexNumber(a: 3, b: 12)
        let comp3 = ComplexNumber(a: -3, b: -12)
        let comp4 = ComplexNumber(a: 0.5, b: 3.4)
        XCTAssertEqual(comp - comp2, ComplexNumber(a: -1, b: -5))
        XCTAssertEqual(comp - comp3, ComplexNumber(a: 5, b: 19))
        XCTAssertEqual(comp - comp4, ComplexNumber(a: 1.5, b: 3.6))

        var comp5 = ComplexNumber(a: 4, b: 9)
        comp5 -= comp2
        XCTAssertEqual(comp5, ComplexNumber(a: 1, b: -3))
    }

    func testMultiplication() {
        let comp = ComplexNumber(a: 2, b: 7)
        let comp2 = ComplexNumber(a: 3, b: 12)
        let comp3 = ComplexNumber(a: -3, b: -12)
        let comp4 = ComplexNumber(a: 0.5, b: 3.4)
        XCTAssertEqual(comp * comp2, ComplexNumber(a: -78, b: 45))
        XCTAssertEqual(comp * comp3, ComplexNumber(a: 78, b: -45))
        XCTAssertEqual(comp * comp4, ComplexNumber(a: -22.8, b: 10.3))

        var comp5 = ComplexNumber(a: 4, b: 9)
        comp5 *= comp2
        XCTAssertEqual(comp5, ComplexNumber(a: -96, b: 75))
    }

    func testDivision() {
        let comp = ComplexNumber(a: 2, b: 7)
        let comp2 = ComplexNumber(a: 3, b: 12)
        let comp3 = ComplexNumber(a: -3, b: -12)
        let comp4 = ComplexNumber(a: 0.5, b: 3.5)
        XCTAssertEqual(comp / comp2, ComplexNumber(a: 30/51, b: -1/51))
        XCTAssertEqual(comp / comp3, ComplexNumber(a: -30/51, b: 1/51))
        XCTAssertEqual(comp / comp4, ComplexNumber(a: 2.04, b: -0.28))

        var comp5 = ComplexNumber(a: 4, b: 9)
        comp5 /= comp2
        XCTAssertEqual(comp5, ComplexNumber(a: 40/51, b: -7/51))
    }
}
