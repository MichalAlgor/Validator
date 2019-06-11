import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(AndCompositeValidatorTests.allTests),
		testCase(EmailFormatValidatorTests.allTests),
		testCase(EmptyStringValidatorTests.allTests),
		testCase(OrCompositeValidatorTests.allTests),
		testCase(PasswordLengthValidatorTests.allTests),
		testCase(UppercaseLetterValidatorTests.allTests),
    ]
}
#endif
