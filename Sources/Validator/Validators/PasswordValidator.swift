//
//  PasswordValidator.swift
//  Validator
//
//  Created by Michal Czupryna on 08.08.2018.
//  Copyright © 2018 Czupryna. All rights reserved.
//

import Foundation

public enum PasswordValidatorError: Error {
	case empty
	case tooShort(`is`: Int, shouldBe: Int)
	case noUppercaseLetter
	case noLowercaseLetter
	case noNumber
}
