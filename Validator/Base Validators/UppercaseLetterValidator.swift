//
//  UppercaseLetterValidator.swift
//  Validator
//
//  Created by Michal Czupryna on 08.08.2018.
//  Copyright © 2018 Czupryna. All rights reserved.
//

import Foundation

public struct UppercaseLetterValidator: Validator {

	public func validate(_ value: String) -> ValidatorResult {
		let uppercaseLetterRegex = ".*[A-Z]+.*"

		let uppercaseLetterTest = NSPredicate(format: "SELF MATCHES %@", uppercaseLetterRegex)

		guard uppercaseLetterTest.evaluate(with: value) else {
			return .invalid(errors: [PasswordValidatorError.noUppercaseLetter])
		}
		return .valid
	}
}
