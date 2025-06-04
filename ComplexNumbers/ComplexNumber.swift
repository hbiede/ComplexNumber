//
//  ComplexNumber.swift
//  ComplexNumbers
//
//  Created by Elijah on 9/22/23.
//

import Foundation

struct ComplexNumber {

    var a: Double
    var b: Double

    init(_ a: Double, _ b: Double) {
        self.a = a
        self.b = b
    }

    init?<T>(exactly source: T) where T : BinaryInteger {
        a = Double(source)
        b = 0
    }

    var conjugate: ComplexNumber {
        ComplexNumber(self.a, -1 * self.b)
    }

    var i: ComplexNumber {
        ComplexNumber(0, b)
    }
}

extension ComplexNumber: CustomStringConvertible {
    var description: String {
        switch (a, b) {
        case (_, .zero):
            "\(a)"
        case (.zero, _):
            "\(b)i"
        case (_, 0..<Double.infinity):
            "\(a) + \(b)i"
        default:
            "\(a) - \(abs(b))i"
        }
    }
}

extension ComplexNumber: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.a == rhs.a && lhs.b == rhs.b
    }
}

extension ComplexNumber: Numeric {
    typealias Magnitude = Double
    var magnitude: Double {
        sqrt(pow(a, 2) + pow(b, 2))
    }

    static func * (lhs: Self, rhs: Self) -> Self {
        ComplexNumber(
            lhs.a * rhs.a - (lhs.b * rhs.b),
            lhs.a * rhs.b + lhs.b * rhs.a
        )
    }
    static func *= (lhs: inout Self, rhs: Self) {
        let origA = lhs.a
        lhs.a = lhs.a * rhs.a - (lhs.b * rhs.b)
        lhs.b = origA * rhs.b + lhs.b * rhs.a
    }
}

extension ComplexNumber: ExpressibleByIntegerLiteral {
    typealias IntegerLiteralType = Int
    init(integerLiteral value: Int) {
        a = Double(value)
        b = 0
    }
}

extension ComplexNumber: ExpressibleByFloatLiteral {
    typealias FloatLiteralType = Double
    init(floatLiteral value: Double) {
        a = value
        b = 0
    }
}

extension ComplexNumber: AdditiveArithmetic {
    static func + (lhs: Self, rhs: Self) -> Self {
        ComplexNumber(lhs.a + rhs.a, lhs.b + rhs.b)
    }
    static func += (lhs: inout Self, rhs: Self) {
        lhs.a += rhs.a
        lhs.b += rhs.b
    }

    static func - (lhs: Self, rhs: Self) -> Self {
        ComplexNumber(lhs.a - rhs.a, lhs.b - rhs.b)
    }
    static func -= (lhs: inout Self, rhs: Self) {
        lhs.a -= rhs.a
        lhs.b -= rhs.b
    }

    static func / (lhs: Self, rhs: Self) -> Self {
        ComplexNumber(
            (lhs.a * rhs.a + lhs.b * rhs.b) / (pow(rhs.a, 2) + pow(rhs.b, 2)),
            (lhs.b * rhs.a - lhs.a * rhs.b) / (pow(rhs.a, 2) + pow(rhs.b, 2))
        )
    }
    static func /= (lhs: inout Self, rhs: Self) {
        let origA = lhs.a
        lhs.a = (lhs.a * rhs.a + lhs.b * rhs.b) / (pow(rhs.a, 2) + pow(rhs.b, 2))
        lhs.b = (lhs.b * rhs.a - origA * rhs.b) / (pow(rhs.a, 2) + pow(rhs.b, 2))
    }
}

extension ComplexNumber: SignedNumeric {
    prefix static func - (operand: Self) -> Self {
        ComplexNumber(-operand.a, -operand.b)
    }

    mutating func negate() {
        self.a.negate()
        self.b.negate()
    }
}
