//
//  Threads.swift
//  MonoReport
//
//  Created by Алекс Ломовской on 19.03.2022.
//

import RxSwift
import RxCocoa

// MARK: - ThreadQueue
enum ThreadQueue {
    static let userInitiatedConcurent = DispatchQueue(
        label: "app.mono.report.queue.concurent.userInitiated",
        qos: .userInitiated,
        attributes: .concurrent
    )
    static let userSerialInitiated = DispatchQueue(
        label: "app.mono.report.queue.serial.userInitiated",
        qos: .userInitiated
    )
    static let utilityConcurrent = DispatchQueue(
        label: "app.mono.report.queue.concurrent.utility",
        qos: .utility,
        attributes: .concurrent
    )
    static let utilitySerial = DispatchQueue(
        label: "app.mono.report.queue.serial.utility",
        qos: .utility
    )
    static let backgroundSerial = DispatchQueue(
        label: "app.mono.report.queue.serial.background",
        qos: .background
    )
}

enum DispatchQueueScheduler {
    static let userInitiatedConcurrent = ConcurrentDispatchQueueScheduler(queue: ThreadQueue.userInitiatedConcurent);
    static let userInitiatedSerial = ConcurrentDispatchQueueScheduler(queue: ThreadQueue.userSerialInitiated);
    static let utilityConcurrent = ConcurrentDispatchQueueScheduler(queue: ThreadQueue.utilityConcurrent);
    static let utilitySerial = ConcurrentDispatchQueueScheduler(queue: ThreadQueue.utilitySerial);
    static let backgroundSerial = ConcurrentDispatchQueueScheduler(queue: ThreadQueue.backgroundSerial);
}
