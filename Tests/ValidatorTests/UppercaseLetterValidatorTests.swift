//
//  UppercaseLetterValidatorTests.swift
//  ValidatorTests
//
//  Created by Michal Czupryna on 09.08.2018.
//  Copyright © 2018 Czupryna. All rights reserved.
//

import XCTest
@testable import Validator

class UppercaseLetterValidatorTests: XCTestCase {

	func testValidString() {
		let validator = UppercaseLetterValidator()
		let result = validator.validate("VALID STRING")
		XCTAssertTrue(result == ValidatorResult.valid, "Validation result should be valid")
	}

	func testInvalidString() {
		let validator = UppercaseLetterValidator()
		let result = validator.validate("invalid string")
		XCTAssertTrue(result != ValidatorResult.valid, "Validation result should be invalid")
	}

	func testInvalidStringReturnProperError() {
		let validator = UppercaseLetterValidator()
		let result = validator.validate("invalid string")
		XCTAssertTrue(result != ValidatorResult.valid, "Validation result should be invalid")
		switch result {
		case .invalid(errors: let errors):
			XCTAssertTrue(errors.contains(where: { (error) -> Bool in
				if case PasswordValidatorError.noUppercaseLetter = error {
					return true
				}
				return false
			}), "Should contain \(PasswordValidatorError.noUppercaseLetter)")
		case .valid:
			XCTFail("Should have invalid result")
		}
	}

	static var allTests = [
		("testValidString", testValidString),
		("testInvalidString", testInvalidString),
		("testInvalidStringReturnProperError", testInvalidStringReturnProperError),
	]
}
