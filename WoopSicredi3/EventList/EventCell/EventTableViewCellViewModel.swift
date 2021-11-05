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
    
    func fetchImage(completion: @escaping () -> Void) {
        let url = URL(string: event.image)!
        
        EventAPIManager.shared.requestImage(url: url) { result in
            switch result {
            case .success(let data):
                self.image = data
                completion()
            case .failure(let error):
                print(error)
                self.image = nil
                completion()
            }
        }
    }
}
