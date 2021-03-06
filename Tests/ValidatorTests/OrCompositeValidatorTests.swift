//
//  OrCompositeValidatorTests.swift
//  ValidatorTests
//
//  Created by Michal Czupryna on 09.08.2018.
//  Copyright © 2018 Czupryna. All rights reserved.
//

import XCTest
@testable import Validator

class OrCompositeValidatorTests: XCTestCase {

	func testValidValidation() {
		let emptyStringValidator = EmptyStringValidator(invalidError: EmptyStringError.emptyString)
		let lengthValidator = PasswordLengthValidator(minimumLength: 5)
		let composite = OrCompositeValidator(validators: emptyStringValidator, lengthValidator)
		let result = composite.validate("Valid String")
		XCTAssertTrue(result == ValidatorResult.valid, "Validation result should be valid")
	}

	func testValidOperatorValidation() {
		let emptyStringValidator = EmptyStringValidator(invalidError: EmptyStringError.emptyString)
		let lengthValidator = PasswordLengthValidator(minimumLength: 5)
		let composite = emptyStringValidator || lengthValidator
		let result = composite.validate("Valid String")
		XCTAssertTrue(result == ValidatorResult.valid, "Validation result should be valid")
	}

	func testOneValidValidation() {
		let testString  = "Vali"
		let minimumLength = 5
		let emptyStringValidator = EmptyStringValidator(invalidError: EmptyStringError.emptyString)
		let lengthValidator = PasswordLengthValidator(minimumLength: minimumLength)
		let composite = OrCompositeValidator(validators: emptyStringValidator, lengthValidator)
		let result = composite.validate(testString)
		XCTAssertTrue(result == ValidatorResult.valid, "Validation result should be valid")
	}

	func testOneValidValidationWithOperator() {
		let testString  = "Vali"
		let minimumLength = 5
		let emptyStringValidator = EmptyStringValidator(invalidError: EmptyStringError.emptyString)
		let lengthValidator = PasswordLengthValidator(minimumLength: minimumLength)
		let composite = emptyStringValidator || lengthValidator
		let result = composite.validate(testString)
		XCTAssertTrue(result == ValidatorResult.valid, "Validation result should be valid")
	}

	func testBothInvalidValidation() {
		let testString  = ""
		let minimumLength = 5
		let emptyStringValidator = EmptyStringValidator(invalidError: EmptyStringError.emptyString)
		let lengthValidator = PasswordLengthValidator(minimumLength: minimumLength)
		let composite = OrCompositeValidator(validators: emptyStringValidator, lengthValidator)
		let result = composite.validate(testString)
		XCTAssertTrue(result != ValidatorResult.valid, "Validation result should be valid")
		switch result {
		case .invalid(errors: let errors):
			guard errors.first is EmptyStringError else {
				XCTFail("Should have proper error \(EmptyStringError.emptyString)")
				return
			}
			guard let error2 = errors.last as? PasswordValidatorError, case let PasswordValidatorError.tooShort(length, properLength) = error2 else {
				XCTFail("Should have proper error \(PasswordValidatorError.tooShort(is: testString.count, shouldBe: minimumLength))")
				return
			}
			XCTAssertEqual(length, testString.count, "Should have proper current length information")
			XCTAssertEqual(properLength, minimumLength, "Should have proper minimum length information")
		case .valid:
			XCTFail("Should have invalid result")
		}
	}

	func testBothInvalidValidationWithOperator() {
		let testString  = ""
		let minimumLength = 5
		let emptyStringValidator = EmptyStringValidator(invalidError: EmptyStringError.emptyString)
		let lengthValidator = PasswordLengthValidator(minimumLength: minimumLength)
		let composite = emptyStringValidator || lengthValidator
		let result = composite.validate(testString)
		XCTAssertTrue(result != ValidatorResult.valid, "Validation result should be valid")
		switch result {
		case .invalid(errors: let errors):
			guard errors.first is EmptyStringError else {
				XCTFail("Should have proper error \(EmptyStringError.emptyString)")
				return
			}
			guard let error2 = errors.last as? PasswordValidatorError, case let PasswordValidatorError.tooShort(length, properLength) = error2 else {
				XCTFail("Should have proper error \(PasswordValidatorError.tooShort(is: testString.count, shouldBe: minimumLength))")
				return
			}
			XCTAssertEqual(length, testString.count, "Should have proper current length information")
			XCTAssertEqual(properLength, minimumLength, "Should have proper minimum length information")
		case .valid:
			XCTFail("Should have invalid result")
		}
	}

	static var allTests = [
		("testValidValidation", testValidValidation),
		("testValidOperatorValidation", testValidOperatorValidation),
		("testOneValidValidation", testOneValidValidation),
		("testOneValidValidationWithOperator", testOneValidValidationWithOperator),
		("testBothInvalidValidation", testBothInvalidValidation),
		("testBothInvalidValidationWithOperator", testBothInvalidValidationWithOperator),
	]
}
