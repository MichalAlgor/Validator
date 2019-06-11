//
//  PasswordLengthValidatorTests.swift
//  ValidatorTests
//
//  Created by Michal Czupryna on 08.08.2018.
//  Copyright © 2018 Czupryna. All rights reserved.
//

import XCTest
@testable import Validator

class PasswordLengthValidatorTests: XCTestCase {

	func testValidDefaultPasswordLength() {
		let validator = PasswordLengthValidator()
		let result = validator.validate("12345678")
		XCTAssertTrue(result == ValidatorResult.valid, "Validation result should be valid")
	}

	func testInvalidDefaultPasswordLength() {
		let validator = PasswordLengthValidator()
		let result = validator.validate("1234567")
		XCTAssertTrue(result != ValidatorResult.valid, "Validation result should be invalid")
	}

	func testValidPasswordLength() {
		let validator = PasswordLengthValidator(minimumLength: 5)
		let result = validator.validate("12345678")
		XCTAssertTrue(result == ValidatorResult.valid, "Validation result should be valid")
	}

	func testInvalidPasswordLength() {
		let validator = PasswordLengthValidator(minimumLength: 10)
		let result = validator.validate("1234567")
		XCTAssertTrue(result != ValidatorResult.valid, "Validation result should be invalid")
	}

	func testInvalidPasswordLengthError() {
		let minimumLength = 10
		let testPassword = "1234567"
		let validator = PasswordLengthValidator(minimumLength: minimumLength)
		let result = validator.validate(testPassword)
		XCTAssertTrue(result != ValidatorResult.valid, "Validation result should be invalid")
		switch result {
		case .invalid(errors: let errors):
			guard let error = errors.first as? PasswordValidatorError, case let PasswordValidatorError.tooShort(length, properLength) = error else {
				XCTFail("Should have proper error \(PasswordValidatorError.tooShort(is: testPassword.count, shouldBe: minimumLength))")
				return
			}
			XCTAssertEqual(length, testPassword.count, "Should have proper current length information")
			XCTAssertEqual(properLength, minimumLength, "Should have proper minimum length information")
		case .valid:
			XCTFail("Should have invalid result")
		}
	}

	static var allTests = [
		("testValidDefaultPasswordLength", testValidDefaultPasswordLength),
		("testInvalidDefaultPasswordLength", testInvalidDefaultPasswordLength),
		("testValidPasswordLength", testValidPasswordLength),
		("testInvalidPasswordLength", testInvalidPasswordLength),
		("testInvalidPasswordLengthError", testInvalidPasswordLengthError),
	]
}
