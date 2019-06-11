//
//  EmptyStringValidatorTests.swift
//  ValidatorTests
//
//  Created by Michal Czupryna on 08.08.2018.
//  Copyright © 2018 Czupryna. All rights reserved.
//

import XCTest
@testable import Validator

enum EmptyStringError: Error {
	case emptyString
}

enum NotEmptyStringError: Error {
	case emptyString
}

class EmptyStringValidatorTests: XCTestCase {

    func testValidString() {
		let validator = EmptyStringValidator(invalidError: EmptyStringError.emptyString)
		let result = validator.validate("Valid String")
		XCTAssertTrue(result == ValidatorResult.valid, "Validation result should be valid")
    }

	func testInvalidString() {
		let validator = EmptyStringValidator(invalidError: EmptyStringError.emptyString)
		let result = validator.validate("")
		XCTAssertTrue(result == ValidatorResult.invalid(errors: []), "Validation result should be invalid")
	}

	func testInvalidStringReturnProperError() {
		let validator = EmptyStringValidator(invalidError: EmptyStringError.emptyString)
		let result = validator.validate("")
		XCTAssertTrue(result != ValidatorResult.valid, "Validation result should be invalid")
		switch result {
		case .invalid(errors: let errors):
			XCTAssertTrue(errors.contains(where: { (error) -> Bool in
				if case EmptyStringError.emptyString = error {
					return true
				}
				if case NotEmptyStringError.emptyString = error {
					return false
				}
				return false
			}), "Should contain \(EmptyStringError.emptyString)")
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
