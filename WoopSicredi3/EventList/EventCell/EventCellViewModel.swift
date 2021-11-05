//
//  EventCellViewModel.swift
//  WoopSicredi3
//
//  Created by Jobe Diego Dylbas dos Santos on 01/11/21.
//

import Foundation
import RxSwift
import RxCocoa

final class EventTableViewCellViewModel {
    var event: Event
    
    init(event: Event) {
        self.event = event
    }
}
