//
//  EmailFormatValidatorTests.swift
//  ValidatorTests
//
//  Created by Michal Czupryna on 08.08.2018.
//  Copyright © 2018 Czupryna. All rights reserved.
//

import XCTest
@testable import Validator

class EmailFormatValidatorTests: XCTestCase {

    func testProperEmailFormat() {
		let validator = EmailFormatValidator()
		let result = validator.validate("valid@validator.com")
		XCTAssertTrue(result == ValidatorResult.valid, "Validation result should be valid")
    }

	func testMissingTopLevelDomain() {
		let validator = EmailFormatValidator()
		let result = validator.validate("valid@validator")
		XCTAssertTrue(result != ValidatorResult.valid, "Validation result should be invalid")
	}

	func testMissingTopLevelDomainWithDot() {
		let validator = EmailFormatValidator()
		let result = validator.validate("valid@validator.")
		XCTAssertTrue(result != ValidatorResult.valid, "Validation result should be invalid")
	}

	func testMissingDomain() {
		let validator = EmailFormatValidator()
		let result = validator.validate("valid@")
		XCTAssertTrue(result != ValidatorResult.valid, "Validation result should be invalid")
	}

	func testMissingAt() {
		let validator = EmailFormatValidator()
		let result = validator.validate("valid.validator.com")
		XCTAssertTrue(result != ValidatorResult.valid, "Validation result should be invalid")
	}

	func testMissingLocalPart() {
		let validator = EmailFormatValidator()
		let result = validator.validate("@validator.com")
		XCTAssertTrue(result != ValidatorResult.valid, "Validation result should be invalid")
	}

	func testMissingLocalPartAndAt() {
		let validator = EmailFormatValidator()
		let result = validator.validate("validator.com")
		XCTAssertTrue(result != ValidatorResult.valid, "Validation result should be invalid")
	}

	static var allTests = [
		("testProperEmailFormat", testProperEmailFormat),
		("testMissingTopLevelDomain", testMissingTopLevelDomain),
		("testMissingTopLevelDomainWithDot", testMissingTopLevelDomainWithDot),
		("testMissingDomain", testMissingDomain),
		("testMissingAt", testMissingAt),
		("testMissingLocalPart", testMissingLocalPart),
		("testMissingLocalPartAndAt", testMissingLocalPartAndAt),
	]
}
