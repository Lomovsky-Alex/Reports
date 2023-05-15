//
//  ClientInfoService.swift
//  MonoReport
//
//  Created by Алекс Ломовской on 19.03.2022.
//

import RxSwift

// MARK: - Protocol
protocol MonoService: TemplateApi {
  func fetchClientInfo() -> Observable<ClientDTO>
}

// MARK: - MonoService
final class MonoServiceImpl: TemplateApiImpl, MonoService {
  func fetchClientInfo() -> Observable<ClientDTO> {
    return manager.request(with: .clientInfo)
  }
}
