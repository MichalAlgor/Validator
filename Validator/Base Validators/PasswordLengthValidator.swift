//
//  PasswordLengthValidator.swift
//  Validator
//
//  Created by Michal Czupryna on 08.08.2018.
//  Copyright © 2018 Czupryna. All rights reserved.
//

import Foundation

public struct PasswordLengthValidator: Validator {

	private let minimumLength: Int

	init() {
		self.init(minimumLength: 8)
	}

	init(minimumLength: Int) {
		self.minimumLength = minimumLength
	}

	public func validate(_ value: String) -> ValidatorResult {
		guard value.count >= minimumLength else {
			let error = PasswordValidatorError.tooShort(is: value.count, shouldBe: minimumLength)
			return .invalid(errors: [error])
		}
		return .valid
	}
}
