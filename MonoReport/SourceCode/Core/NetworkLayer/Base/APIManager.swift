//
//  APIManager.swift
//  MonoReport
//
//  Created by Алекс Ломовской on 19.03.2022.
//

import RxSwift
import Moya

// MARK: - APIManager+Cases
enum APIManager {
  fileprivate static let obfuscator = Obfuscator(with: Constants.Credentials.obfuscatorSalt)
  case clientInfo
}

// MARK: - APIManager
extension APIManager: TargetType {
  var baseURL: URL {
    return URL(string: "https://api.monobank.ua/")!
  }
  
  var path: String {
    switch self {
      case .clientInfo:
        return "/personal/client-info"
    }
  }
  
  var method: Moya.Method {
    switch self {
      default:
        return .get
    }
  }
  
  var sampleData: Data {
    return Data()
  }
  
  var task: Task {
    var params = [String: Any]()
    switch self {
      default:
        break
    }
    return params.isEmpty ?
        .requestPlain :
        .requestParameters(parameters: params, encoding: URLEncoding.queryString)
  }
  
  var headers: [String : String]? {
    var httpHeaders = [String: String]();
    httpHeaders["Content-type"] = "application/json";
    httpHeaders["Accept"] = "application/json";
    switch self {
      default:
        httpHeaders["X-Token"] = APIManager.obfuscator.reveal(key: Constants.Credentials.xtoken)
    }
    return httpHeaders;
  }
}
