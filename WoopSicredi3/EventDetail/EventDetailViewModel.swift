//
//  EventDetailViewModel.swift
//  WoopSicredi3
//
//  Created by Jobe Diego Dylbas dos Santos on 04/11/21.
//

import Foundation


class EventDetailViewModel {
    
    // MARK: - Public Properties
    
    var event: Event
    var image: Data?
    
    // MARK: - Inits
    
    init(event: Event) {
        self.event = event
    }
    
    // MARK: - Public Methods
    
    func getDate() -> String {
        let epochTime = TimeInterval(self.event.date/1000)
        let date = Date(timeIntervalSince1970: epochTime)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy" //Specify your format that you want
        return dateFormatter.string(from: date)
    }
    
    func getPrice() -> String {
        return String(format: "R$ %.2f", event.price)
    }
}
