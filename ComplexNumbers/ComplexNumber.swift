//
//  ComplexNumber.swift
//  ComplexNumbers
//
//  Created by Elijah on 9/22/23.
//

import Foundation

struct ComplexNumber : Equatable,
                       ExpressibleByIntegerLiteral,
                       Numeric,
                       SignedNumeric {
    
    private var a, b: Double

    typealias IntegerLiteralType = Int
    init(a: Double, b: Double) {
        self.a = a
        self.b = b
    }
    init(integerLiteral value: Int) {
        a = Double(value)
        b = 0
    }
    init?<T>(exactly source: T) where T : BinaryInteger {
        a = Double(source)
        b = 0
    }

    typealias Magnitude = Double
    var magnitude: Double {
        get {
            sqrt(pow(a, 2) + pow(b, 2))
        }
    }

    func conjugate() -> ComplexNumber {
        ComplexNumber(a: self.a, b: -1 * self.b)
    }

    mutating func negate() {
        self.a.negate()
        self.b.negate()
    }

    static func + (lhs: ComplexNumber, rhs: ComplexNumber) -> ComplexNumber {
        ComplexNumber(a: lhs.a + rhs.a, b: lhs.b + rhs.b)
    }
    static func += (lhs: inout ComplexNumber, rhs: ComplexNumber) {
        lhs.a += rhs.a
        lhs.b += rhs.b
    }

    static func - (lhs: ComplexNumber, rhs: ComplexNumber) -> ComplexNumber {
        ComplexNumber(a: lhs.a - rhs.a, b: lhs.b - rhs.b)
    }
    static func -= (lhs: inout ComplexNumber, rhs: ComplexNumber) {
        lhs.a -= rhs.a
        lhs.b -= rhs.b
    }

    static func * (lhs: ComplexNumber, rhs: ComplexNumber) -> ComplexNumber {
        ComplexNumber(
            a: lhs.a * rhs.a - (lhs.b * rhs.b),
            b: lhs.a * rhs.b + lhs.b * rhs.a
        )
    }
    static func *= (lhs: inout ComplexNumber, rhs: ComplexNumber) {
        let origA = lhs.a
        lhs.a = lhs.a * rhs.a - (lhs.b * rhs.b)
        lhs.b = origA * rhs.b + lhs.b * rhs.a
    }

    static func / (lhs: ComplexNumber, rhs: ComplexNumber) -> ComplexNumber {
        ComplexNumber(
            a: (lhs.a * rhs.a + lhs.b * rhs.b) / (pow(rhs.a, 2) + pow(rhs.b, 2)),
            b: (lhs.b * rhs.a - lhs.a * rhs.b) / (pow(rhs.a, 2) + pow(rhs.b, 2))
        )
    }
    static func /= (lhs: inout ComplexNumber, rhs: ComplexNumber) {
        let origA = lhs.a
        lhs.a = (lhs.a * rhs.a + lhs.b * rhs.b) / (pow(rhs.a, 2) + pow(rhs.b, 2))
        lhs.b = (lhs.b * rhs.a - origA * rhs.b) / (pow(rhs.a, 2) + pow(rhs.b, 2))
    }

    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.a == rhs.a && lhs.b == rhs.b
    }
}
