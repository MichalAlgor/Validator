//
//  CompositeValidator.swift
//  Validator
//
//  Created by Michal Czupryna on 08.08.2018.
//  Copyright © 2018 Czupryna. All rights reserved.
//

import Foundation

public struct AndCompositeValidator: Validator {

	private let validators: [Validator]

	init(validators: Validator...) {
		self.validators = validators
	}

	public func validate(_ value: String) -> ValidatorResult {
		return validators.reduce(.valid) { validatorResult, validator in
			switch validator.validate(value) {
			case .valid:
				return validatorResult
			case .invalid(let validatorErrors):
				switch validatorResult {
				case .valid:
					return .invalid(errors: validatorErrors)
				case .invalid(let validatorResultErrors):
					return .invalid(errors: validatorResultErrors + validatorErrors)
				}
			}
		}
	}
}

public func && (left: Validator, right: Validator) -> Validator {
	return AndCompositeValidator(validators: left, right)
}
