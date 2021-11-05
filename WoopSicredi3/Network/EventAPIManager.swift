//
//  EventAPIManager.swift
//  WoopSicredi3
//
//  Created by Jobe Diego Dylbas dos Santos on 01/11/21.
//

import Foundation

enum Result<Success, Failure> where Failure: Error {
    case success(Success)
    case failure(Failure)
}

final class EventAPIManager {
    
    // MARK: - Public Properties
    
    static let shared = EventAPIManager()
    
    // MARK: - Private Properties
    
    private let baseURL = "http://5f5a8f24d44d640016169133.mockapi.io/api/events"
    private let checkInURL = "http://5f5a8f24d44d640016169133.mockapi.io/api/checkin"
    
    private enum HTTPMethod: String {
        case get  = "GET"
        case post = "POST"
    }
    
    // MARK: - Public Methods
    
    func requestEvents(completion: @escaping (Result<[Event], Error>) -> Void) {
        let url = URL(string: baseURL)!
        
        let _ = URLSession.shared.dataTask(with: url) { result in
            switch result {
            case .success(let data):
                do {
                let events = try JSONDecoder().decode([Event].self, from: data)
                
                completion(.success(events))
            } catch {
                print(error)
                completion(.failure(error))
            }
            case .failure(let error):
                print(error)
                completion(.failure(error))
            }
        }.resume()
    }
    
    func requestImage(url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        let _ = URLSession.shared.dataTask(with: url) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                print(error)
                completion(.failure(error))
            }
        }.resume()
    }
    
    func makeCheckIn(eventId: String, name: String, email: String, completion: @escaping (Result<Data, Error>) -> Void) {
        let url = URL(string: checkInURL)!
        let parameters: [String: String] = [
            "eventId": eventId,
            "name": name,
            "email": email
        ]
        
        var req = URLRequest(url: url)
        
        req.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        req.httpMethod = HTTPMethod.post.rawValue
        
        do {
            req.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch {
            print(error.localizedDescription)
            completion(.failure(error))
        }
        
        let _ = URLSession.shared.dataTask(with: req) { data, response, error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(Data()))
            }
        }.resume()
    }
}
