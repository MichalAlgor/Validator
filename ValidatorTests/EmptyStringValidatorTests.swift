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

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

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

}
