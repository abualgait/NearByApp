 

import Foundation
import Alamofire

enum  SSErrorType : Int {
    // API errors
    case Undefined = 0
    case VerifyAccount
    case Unknown
    case BadRequest
    case Unauthorized
    case Forbidden
    case NotFound
    case Conflict
    case EmailPasswordExist
    case UserDoesNotExist
    case ServerError
    case ServerUnavailable
    case AppVersionNotSupported
    case ConnectionCancelled
    case ConnectionError
    case NoNetwork
    case JSONParserError
    case DataModelError
    case RestrictedUser
    case BlacklistedUser
    case LikeBeforeUnlike
    case ContentFilter
    case InvalidFacebookToken
    
    // AOuth errors
    case OAuthGeneralError
    case UserCredentialsIncorrect
    case InvalidRefreshToken
    case InvalidRequest
    case EmailValidationError
    case UnexpectedResponse
}

enum  SSErrorResolutionType : Int {
    case ShowAlertAndContinue = 1
    case HandleInApp
    case RequestUpgradeAndBlock
    case ForceLogin
}

let kSSErrorObjectKey: String = "SSErrorObjectKey"

class SSError: NSObject {
    
    var code: String = ""
    var from: String = ""
    var message: String = ""
    var warning_type: String = ""
    var nserror: Error?
    var operation: HTTPURLResponse?
    var errorType = SSErrorType(rawValue:0)
    var isErrorShown: Bool = false
    
    override init() {
        super.init()
    }
    
    init(message msg: String, code: String, from: String, errorType: SSErrorType) {
        super.init()
        
        self.errorType = errorType
        self.message = msg
        self.code = code
        self.from = from
        isErrorShown = false
    }
    
    init(operation: HTTPURLResponse?, error: Error?) {
        super.init()
        
        self.operation = operation
        message = (error?.localizedDescription)!
        nserror = error
        isErrorShown = false
        errorType = errorTypeFromState()
    }
    
    class func errorWithData(data: DataResponse<Any>) -> Error {
        return errorWithData(data: data.data, operation: data.response, error: data.error)
    }
    
    class func errorWithData(data: Data?, operation: HTTPURLResponse?, error: Error?) -> Error {
        let ssError = SSError()
        ssError.operation = operation
        ssError.nserror = error
        ssError.errorType = ssError.errorTypeFromState()
        ssError.isErrorShown = false
        
        // Setting message
        let errorMessageFromData = getErrorMessageFromData(data)
        if (errorMessageFromData != nil) {
            ssError.message = errorMessageFromData!
        } else if let errorMessageFromError = error?.localizedDescription  {
            ssError.message = errorMessageFromError
        } else {
            ssError.message = getErrorMessage(error)
        }
        
        // Setting specific message for cancel request error
        if let tempError = error {
            let tempNSError = tempError as NSError
            if tempNSError.code == -999 {
                ssError.message = "cancelled_request" 
                ssError.code = String(format: "%d", tempNSError.code)
            }
        }
        
        var userInfo = [String : Any]()
        userInfo[kSSErrorObjectKey] = ssError
        let nsError = NSError(domain: "", code: Int(ssError.code) ?? 0, userInfo: userInfo)
        
        return nsError
    }
    
    class func getErrorMessageFromData(_ data: Data?) -> String? {
        if let tempData = data {
            if tempData.count > 0 {
                do {
                    let jsonObject = try JSONSerialization.jsonObject(with: tempData, options: [.mutableLeaves])
                    if let jsonDict = jsonObject as? NSDictionary {
                        if let message = jsonDict["message"] as? String {
                            if Utility.isEmpty(message) {
                                SSLog(message: "Message is empty")
                            } else {
                                return message
                            }
                        } else {
                            SSLog(message: "Failed to get message from NSDictionary")
                        }
                    } else {
                        SSLog(message: "Failed to convert json object into NSDictionary")
                        if let jsonSwiftDict = jsonObject as? [String : Any] {
                            if let message = jsonSwiftDict["message"] as? String {
                                if Utility.isEmpty(message) {
                                    SSLog(message: "Message is empty")
                                } else {
                                    return message
                                }
                            } else {
                                SSLog(message: "Failed to get message from Swift Dictionary")
                            }
                        } else {
                            SSLog(message: "Failed to convert json object into Swift Dictionary")
                        }
                    }
                } catch {
                    SSLog(message: "Failed to convert data into json object")
                    SSLog(message: String(data: tempData, encoding: .utf8) ?? "Failed to convert data into String")
                }
            }
        }
        
        return nil
    }
    
    class func errorWithError(error: Error) -> Error {
        let ssError = SSError()
        ssError.nserror = error
        ssError.errorType = ssError.errorTypeFromState()
        ssError.isErrorShown = false
        ssError.message = getErrorMessage(error)
        if ssError.message == "" {
            let tempNSError = error as NSError
            ssError.message = tempNSError.localizedDescription
            ssError.code = String(format: "%d", tempNSError.code)
        }
        
        var userInfo = [String : Any]()
        userInfo[kSSErrorObjectKey] = ssError
        let nsError = NSError(domain: "", code: Int(ssError.code) ?? 0, userInfo: userInfo)
        
        return nsError
    }
    
    func errorWithMediError() -> Error? {
        var tmp = [AnyHashable: Any]()
        tmp[kSSErrorObjectKey] = self
        var newError: Error?
        if (nserror != nil) {
            for (k, v) in (nserror as! NSError).userInfo { tmp.updateValue(v, forKey: k) }
            newError = NSError(domain: (nserror as! NSError).domain, code: (nserror as! NSError).code, userInfo: tmp as! [String : Any])
        }
        else {
            newError = NSError(domain: "", code: 0, userInfo: tmp as? [String : Any])
        }
        return newError
    }
    
    func errorTypeFromState() -> SSErrorType {
        
        // In the case of no internet or no response got from server
        if (operation == nil)  {
            return .ConnectionError
        }
        
        switch operation!.statusCode {
        case 400:
            return .BadRequest;
        case 401:
            return .Unauthorized;
        case 403:
            return .Forbidden;
        case 404:
            return .NotFound;
        case 409:
            return .Conflict;
        case 500:
            return .ServerError;
        case 503:
            return .ServerUnavailable;
        case 504:
            return .ServerUnavailable;
        default:
            return .Unknown;
        }
    }
    
    func errorResolutionType() -> SSErrorResolutionType {
        var resolutionType: SSErrorResolutionType
        switch errorType! {
        case .BadRequest:
            resolutionType = .HandleInApp
        case .Unauthorized:
            resolutionType = .HandleInApp
        case .AppVersionNotSupported:
            resolutionType = .RequestUpgradeAndBlock
        case .Forbidden:
            resolutionType = .HandleInApp
        case .NotFound:
            resolutionType = .HandleInApp
        case .EmailPasswordExist:
            resolutionType = .HandleInApp
        case .UserDoesNotExist:
            resolutionType = .HandleInApp
        case .Conflict:
            resolutionType = .ShowAlertAndContinue
        case .ServerError:
            resolutionType = .ShowAlertAndContinue
        case .ServerUnavailable:
            resolutionType = .ShowAlertAndContinue
        case .ConnectionError:
            resolutionType = .HandleInApp
        case .ConnectionCancelled:
            resolutionType = .HandleInApp
        case .NoNetwork:
            resolutionType = .HandleInApp
        case .JSONParserError:
            resolutionType = .ShowAlertAndContinue
        case .DataModelError:
            resolutionType = .ShowAlertAndContinue
        case .OAuthGeneralError:
            resolutionType = .ForceLogin
        case .UserCredentialsIncorrect:
            resolutionType = .HandleInApp
        case .InvalidRefreshToken:
            resolutionType = .ForceLogin
        case .InvalidRequest:
            resolutionType = .HandleInApp
        case .RestrictedUser:
            resolutionType = .HandleInApp
        case .BlacklistedUser:
            resolutionType = .ShowAlertAndContinue
        case .LikeBeforeUnlike:
            resolutionType = .HandleInApp
        case .ContentFilter:
            resolutionType = .ShowAlertAndContinue
        case .InvalidFacebookToken:
            resolutionType = .HandleInApp
        case .EmailValidationError:
            resolutionType = .ShowAlertAndContinue
        case .VerifyAccount:
            resolutionType = .ShowAlertAndContinue
        default:
            resolutionType = .ShowAlertAndContinue
        }
        
        return resolutionType
    }
    
    //  Converted with Swiftify v1.0.6402 - https://objectivec2swift.com/
    func localizedMessage() -> String {
        var localizedMessage: String
        //if ([self.message isEmpty])
        do {
            //  self.message = NSLocalizedString(@"error_message_generic", nil);
        }
        switch errorType! {
        case .BadRequest:
            localizedMessage = message
        case .VerifyAccount:
            localizedMessage = message
        case .Unauthorized:
            localizedMessage = NSLocalizedString("error_unauthorized", comment: "")
        case .AppVersionNotSupported:
            localizedMessage = message
        case .Forbidden:
            localizedMessage = message
        case .NotFound:
            localizedMessage = message
        case .EmailPasswordExist:
            localizedMessage = message
        case .UserDoesNotExist:
            localizedMessage = message
        case .Conflict:
            localizedMessage = message
        case .ServerError:
            localizedMessage = NSLocalizedString("error_message_500", comment: "")
        case .ServerUnavailable:
            localizedMessage = NSLocalizedString("error_message_503", comment: "")
        case .ConnectionError:
            localizedMessage = NSLocalizedString("error_message_connection_error", comment: "")
        case .NoNetwork:
            localizedMessage = NSLocalizedString("error_message_no_network", comment: "")
        case .JSONParserError:
            localizedMessage = NSLocalizedString("error_message_500", comment: "")
        case .DataModelError:
            localizedMessage = NSLocalizedString("error_message_500", comment: "")
        case .InvalidRefreshToken:
            localizedMessage = NSLocalizedString("error_message_401", comment: "")
        case .OAuthGeneralError:
            localizedMessage = NSLocalizedString("error_message_500", comment: "")
        case .ContentFilter:
            localizedMessage = NSLocalizedString("error_behind_contentfilter", comment: "")
        case .InvalidFacebookToken:
            localizedMessage = NSLocalizedString("error_invalid_facebook_token", comment: "")
        case .EmailValidationError:
            localizedMessage = NSLocalizedString("invalid_email", comment: "")
        default:
            localizedMessage = message
        }
        
        return localizedMessage
    }
    
    
    func localizedTitle() -> String {
        return NSLocalizedString("app_name", comment: "")
    }
    
    func debugFullDescription() -> String {
        return "Error: \(nserror!.localizedDescription)\nMessage: \(message)\nCode: \(code)\nFrom: \(from)"
    }
    
    
    func showAlertIfNeeded() {
        if isErrorShown {
            return
        }
        isErrorShown = true
        DispatchQueue.main.async(execute: {() -> Void in
            switch self.errorResolutionType() {
            case .ShowAlertAndContinue:
                self.showNormalAlert()
            default:
                #if DEBUG
                    if self.errorType != .ConnectionCancelled {
                        /*UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Debug info"
                         message:[self debugDescription]
                         delegate:nil
                         cancelButtonTitle:NSLocalizedString(@"ok_capital", nil)
                         otherButtonTitles:nil];
                         [alert show];*/
                    }
                #endif
            }
            
        })
        //VVLog(@"%@", [self debugDescription]);
    }
    
    func showNormalAlert() {
        /*
         #ifdef DEBUG
         NSString* message = [NSString stringWithFormat:@"%@\n\nDebug info\n%@", [self localizedMessage], [self debugDescription]];
         #else
         NSString* message = [self localizedMessage];
         #endif
         UIAlertView* alert = [[UIAlertView alloc] initWithTitle:[self localizedTitle] message:message delegate:nil cancelButtonTitle:NSLocalizedString(@"ok_capital", nil) otherButtonTitles:nil];
         [alert show];*/
    }
    
    class func getErrorMessage(_ error: Error?) -> String {
        let nserror =  (error! as NSError).userInfo[kSSErrorObjectKey]
        let sserror = nserror as! SSError
        
        return sserror.localizedMessage()
    }
    
    class func isErrorReponse(operation: HTTPURLResponse?) -> Bool
    {
        if (operation == nil)
        {
            return true
        }
        else if((operation?.statusCode)!>=300)
        {
            return true
        }
        return false
        
    }
}

