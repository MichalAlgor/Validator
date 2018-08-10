//
//  EmailValidator.swift
//  Validator
//
//  Created by Michal Czupryna on 08.08.2018.
//  Copyright © 2018 Czupryna. All rights reserved.
//

import Foundation

public enum EmailValidatorError: Error {
	case empty
	case invalidFormat
}
