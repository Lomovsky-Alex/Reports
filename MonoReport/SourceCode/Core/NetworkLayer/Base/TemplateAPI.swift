//
//  TemplateAPI.swift
//  MonoReport
//
//  Created by Алекс Ломовской on 19.03.2022.
//

import RxSwift

protocol TemplateApi {
    var isLoading: Observable<Bool> { get }
    var bag: DisposeBag { get }
    var manager: NetworkManager { get }
}

//Base class for avoid copy-paste
class TemplateApiImpl: TemplateApi {
    
    let isLoading: Observable<Bool>
    let bag = DisposeBag();
    let manager: NetworkManager
    
    private(set) var activity = PublishSubject<Bool>();
    
    init() {
        isLoading = activity.asObserver().share();
        manager = NetworkManager(isWorking: activity.asObserver());
    }
}

