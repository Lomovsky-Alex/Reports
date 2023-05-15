//
//  NetworkManager.swift
//  MonoReport
//
//  Created by Алекс Ломовской on 19.03.2022.
//

import RxSwift
import Moya

// MARK: - NetworkManager
final class NetworkManager {
  private let networkProvider: MoyaProvider<APIManager>
  let isWorking: PublishSubject<Bool>
  
  init(isWorking: PublishSubject<Bool>) {
    self.isWorking = isWorking
#if DEBUG
    let plugin = NetworkLoggerPlugin(
      configuration: .init(formatter: .init(responseData: jsonResponseDataFormatter), logOptions: .verbose)
    )
    networkProvider = MoyaProvider<APIManager>(plugins: [plugin])
#else
    networkProvider = MoyaProvider<APIManager>()
#endif
  }
  
  func request<T: Codable>(with target: APIManager) -> Observable<T> {
    return Observable.create { observableObject in
      self.isWorking.onNext(true)
      return self.networkProvider.rx
        .request(target, callbackQueue: ThreadQueue.utilitySerial)
        .subscribe { [weak self] response in
          do {
            defer {
              self?.isWorking.onNext(false)
            }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            if response.data.isEmpty {
              observableObject.onNext(NoReply() as! T)
            } else {
              if let error = try? decoder.decode(ErrorDTO.self, from: response.data) {
                observableObject.onError(error)
              } else {
                let entity = try decoder.decode(T.self, from: response.data)
                observableObject.onNext(entity)
              }
            }
          } catch let error {
            Log.e(error)
            observableObject.onError(error)
          }
        } onFailure: { [weak self] moyaError in
          Log.e("Moya error: \(moyaError)")
          self?.isWorking.onNext(false)
          let error = ErrorEntity(code: .serverError, description: Localization.Error.serverError.localized())
          observableObject.onError(error)
        }
    }
    .retry(1)
    .subscribe(on: DispatchQueueScheduler.utilitySerial)
  }
  
}

fileprivate func jsonResponseDataFormatter(_ data: Data) -> String {
  do {
    let dataAsJSON = try JSONSerialization.jsonObject(with: data)
    let prettyData = try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
    return String(data: prettyData, encoding: .utf8) ?? String(data: data, encoding: .utf8) ?? ""
  } catch {
    return String(data: data, encoding: .utf8) ?? ""
  }
}






