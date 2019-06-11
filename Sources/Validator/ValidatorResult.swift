//
//  ValidatorResult.swift
//  Validator
//
//  Created by Michal Czupryna on 08.08.2018.
//  Copyright © 2018 Czupryna. All rights reserved.
//

import Foundation

public enum ValidatorResult {
	case valid
	case invalid(errors: [Error])
}

extension ValidatorResult: Equatable {
	public static func == (lhs: ValidatorResult, rhs: ValidatorResult) -> Bool {
		switch (lhs, rhs) {
		case (.valid, .valid):
			return true
		case (.invalid, .invalid):
			return true
		default:
			return false
		}
	}
}
