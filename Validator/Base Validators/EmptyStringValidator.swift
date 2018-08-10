//
//  EmptyStringValidator.swift
//  Validator
//
//  Created by Michal Czupryna on 08.08.2018.
//  Copyright © 2018 Czupryna. All rights reserved.
//

import Foundation

public struct EmptyStringValidator: Validator {

	// This error is passed via the initializer to allow this validator to be reused
	private let invalidError: Error

	public  init(invalidError: Error) {
		self.invalidError = invalidError
	}

	public func validate(_ value: String) -> ValidatorResult {
		if value.isEmpty {
			return .invalid(errors: [invalidError])
		} else {
			return .valid
		}
	}
}
