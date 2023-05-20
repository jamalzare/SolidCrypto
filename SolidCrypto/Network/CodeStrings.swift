//
//  CodeStrings.swift
//  SolidCrypto
//
//  Created by Jamal on 5/20/23.
//

import Foundation
import UIKit

struct CodeStrings {
    
    static var tenentId = "3fa85f64-5717-4562-b3fc-2c963f66afa5"
    static var gdprId = "3fa85f64-5717-4562-b3fc-2c963f66afa6"
    static var serviceContractId = "3fa85f64-5717-4562-b3fc-2c963f66afa5"
    
    static let trTr = "tr-TR"
    static let enUS = "en-US"
    static let tr = "tr"
    static let TR = "TR"
    
    /// ₺
    static let liraSymbol = "₺"
    
    ///TL
    static let lira = "TL"
    
    static let emailConfirmation = "email-confirmation"
    static let completeForgotPassword = "complete-forgot-password"
    
    static let invalidVerifyLink = "Invalid verify Link"
    static let invalidVerifyLinkMessage = "Your email verification link is not valid."
    static let gSMIsAlreadyUsed = "User:MSISDN_IS_ALREADY_USED"
    static let tabBar = "tabBar"
    static let InvoicesListTableViewCell = "InvoicesListTableViewCell"
    static let didReceiveUnauthorizedError = "didReceiveUnauthorizedError"
    
    static let networkErrorCode = "-1001"
    static let networkErrorCodeTitle = "Network Error: -1001"
    static let networkErrorCodeMessage = "Your net communication interrupted please try again."
    
    static let noJSONDataErrorCode = "-102"
    static let noJSONDataErrorTitle = "No Server JSON Data: -102"
    static let noJSONDataErrorMessage = "Server is not responding any data"
    
    static let dataIsNilErrorTitle = "unknown:"
    static let dataIsNilErrorMessage = "data is nil"
    
    static let tokenIsNotValidErrorTitle = "Unathorized:"
    static let tokenIsNotValidErrorMessage = "Your are not Authorized"
    
    static let internalServerError = "Internal Server Error"
    
    static let responseIsNilErrorCode = "-103"
    static let responseIsNilErrorTitle = "No JSON Data: -103"
    static let responseIsNilErrorMessage = "Server is not responding any data"
    
    static let decodingResponseDataCorruptedCode = "-111"
    static let decodingResponseDataCorruptedTitle = "Decoding Response: -111"
    
    static let decodingResponseKeyNotFoundCode = "-112"
    static let decodingResponseKeyNotFoundTitle = "Decoding Response: -112"
    static let decodingResponseKeyNotFoundMessage = "Key not found"
    static let codingPath = "codingPath"
    
    static let decodingResponseValueNotFoundCode = "-113"
    static let decodingResponseValueNotFoundTitle = "Decoding Response: -113"
    static let decodingResponseValueNotFoundMessage = "Value not found"

    static let decodingResponseTypeMismatchCode = "-114"
    static let decodingResponseTypeMismatchTitle = "Decoding Response: -114"
    static let decodingResponseTypeMismatchMessage = "Type mismatch"
   
    static let decodingResponseUnknownResponseCode = "-115"
    static let decodingResponseUnknownResponseTitle = "Decoding Response: -115"
    
    static let decodeErrorDataCorruptedCode = "-999"
    static let decodeErrorDataCorruptedTitle = "Decoding Error: -999"
    
    static let decodeErrorKeyNotFoundCode = "-998"
    static let decodeErrorKeyNotFoundTitle = "Decoding Error: -998"
    static let decodeErrorKeyNotFoundMessage = "Key not found"
    
    static let decodeErrorValueNotFoundCode = "-997"
    static let decodeErrorValueNotFoundTitle = "Decoding Error: -997"
    static let decodeErrorValueNotFoundMessage = "Value not found"
    
    static let decodeErrorTypeMismatchCode = "-996"
    static let decodeErrorTypeMismatchTitle = "Decoding Error: -996"
    static let decodeErrorTypeMismatchMessage = "Type mismatch"
    
    static let decodeErrorUnknownResponseCode = "-995"
    static let decodeErrorUnknownResponseTitle = "Decoding Error: -995"
    
    static let unknownError = "unknown error"
    static let authorization = "Authorization"
    static let bearer = "Bearer"
    
    static let logStart = "\n*******************************************\n"
    static let logNextLine = "\n-------------------------------------------\n"
    static let logForIdentifier = "Log for request with identifier:"
    static let url = "URL"
    static let method = "Method"
    static let headers = "Headers"
    static let body = "Body"
    static let statusCode = "Status code"
    
    static let error = "ERROR"
    static let response = "Response"
    static let cell = "Cell"
    static let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    static let patternSymbol: Character = "#"
    static let phonePattern = "### ### ## ##"
    static let alreadyRegisteredPhoneFormat = "0(###) ### ## ##"
    static let cardNumberFormat = "#### #### #### ####"
    static let phoneNumberStars = "*** **"
    static let ibanPattern = "TR## #### #### #### #### #### ##"
    static let ibanNumberPattern = "## #### #### #### #### #### ##"
    
    static let loadBalanceSuccess = "Success"
    static let loadBalanceFail = "Fail"
    
    static let amountValuePlaceHolder = "1.250,00"
    static let businessAddressTitle = "İş"
    static let homeAddressTitle = "Ev"
    
    static let contentLocation = "Content-Location"
    static let otpLocation = "/api/notification/v1/sms/verify-otp, /api/notification/v1/sms/resend-otp"
    static let verifyOTPLocation = "verify-otp"
    static let resendOTPLocation = "resend-otp"
    static let changePasswordPeriodLocation = "change-password-period"
    static let siginInCompleteLocation = "/api/core/authentication/sign-in/complete"
    static let moneyTransfersComplete = "/api/core/internal-money-transfers/complete"
    static let completeLocation = "/api/core/internal-money-transfers/complete"
    
    static let customerLevel = "customer_level"
    static let givenname = "givenname"
    static let approvedLevel = "Approved"
    static let standardLevel = "Standard"
    static let anonymousLevel = "Anonymous"
    static let emailaddress = "emailaddress"
    
    static let bullet = "\u{2022}"
    
    static let nviCodeURL = "https://www.turkiye.gov.tr/nvi-adres-bilgilerim"
}
