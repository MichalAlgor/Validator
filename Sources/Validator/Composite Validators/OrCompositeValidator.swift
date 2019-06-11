//
//  OrCompositeValidator.swift
//  Validator
//
//  Created by Michal Czupryna on 08.08.2018.
//  Copyright © 2018 Czupryna. All rights reserved.
//

import Foundation

public struct OrCompositeValidator: Validator {

	private let validators: [Validator]

	public init(validators: Validator...) {
		self.validators = validators
	}

	public func validate(_ value: String) -> ValidatorResult {
		return validators.reduce(.invalid(errors: [])) { validatorResult, validator in
			guard case .invalid(let validatorResultErrors) = validatorResult else {
				return .valid
			}

			switch validator.validate(value) {
			case .valid:
				return .valid
			case .invalid(let validatorErrors):
				return .invalid(errors: validatorResultErrors + validatorErrors)
			}
		}
	}
}

public func || (left: Validator, right: Validator) -> Validator {
	return OrCompositeValidator(validators: left, right)
}
