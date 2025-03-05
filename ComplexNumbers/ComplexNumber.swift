//
//  ComplexNumber.swift
//  ComplexNumbers
//
//  Created by Elijah on 9/22/23.
//

import Foundation

struct ComplexNumber {

    private var a, b: Double

    init(_ a: some FloatingPoint, _ b: some FloatingPoint) {
        self.a = Double(a)
        self.b = Double(b)
    }
    init?(exactly source: BinaryInteger) {
        a = Double(source)
        b = 0
    }

    func conjugate() -> ComplexNumber {
        ComplexNumber(a: self.a, b: -1 * self.b)
    }
}

extension ComplexNumber: CustomStringConvertible {
    var description: String {
        if b == .zero {
            return "\(a)"
        } else if a == .zero {
            return "\(b)i"
        } else if b > 0 {
            return "\(a) + \(b)i"
        } else {
            return "\(a) - \(abs(b))i"
        }
    }
}

extension ComplexNumber: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.a == rhs.a && lhs.b == rhs.b
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

extension ComplexNumber: AdditiveArithmetic, SignedNumeric {
    typealias Magnitude = Double
    var magnitude: Double {
        get {
            sqrt(pow(a, 2) + pow(b, 2))
        }
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
}

extension FloatingPoint {
    var i: ComplexNumber {
        ComplexNumber(0, self)
    }
}
