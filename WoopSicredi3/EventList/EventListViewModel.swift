//
//  EventListViewModel.swift
//  WoopSicredi3
//
//  Created by Jobe Diego Dylbas dos Santos on 01/11/21.
//

import Foundation
import RxSwift

final class EventListViewModel {
    
    // MARK: - Public Properties
    
    var events = PublishSubject<[Event]>()
    
    func fetchEvents() {
        EventAPIManager.shared.requestEvents { result in
            switch result {
            case .success(let events):
                print(events)
                self.events.onNext(events)
            case .failure( _):
                self.events.onNext([])
            }
            self.events.onCompleted()
        }
    }
}
