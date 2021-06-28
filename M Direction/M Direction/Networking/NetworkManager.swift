//
//  NetworkManager.swift
//  M Direction
//
//  Created by Andranik Khachaturyan on 26.06.2021.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    private let urlString = "http://suren077-001-site1.ctempurl.com/api/"
    
    func singIn(_ userType: UserType, data: Data, complition: @escaping (Int?) -> Void) {
        let urlRowValue = urlString + userType.rawValue + "/Login"
        let url = URL(string: urlRowValue)!
        let request: URLRequest = {
            var request = URLRequest(url: url)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "POST"
            request.httpBody = data
            
            return request
        }()
        
        URLSession.shared.dataTask(with: request) { data, responce, error in
            guard let responce = responce as? HTTPURLResponse else {
                print("No data recieved")
                return
            }
            complition(responce.statusCode)
        }.resume()
    }
    
    func sendActivationCode(_ userType: UserType, data: Data, complition: @escaping (Int?) -> Void) {
        let urlRowValue = urlString + userType.rawValue + "/SendActivationCode"
        let url = URL(string: urlRowValue)!
        let request: URLRequest = {
            var request = URLRequest(url: url)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "POST"
            request.httpBody = data
            
            return request
        }()
        
        URLSession.shared.dataTask(with: request) { data, responce, error in
            guard let responce = responce as? HTTPURLResponse else {
                print("No data recieved")
                return
            }
            complition(responce.statusCode)
        }.resume()
    }
    
    func validateActivationCode(_ userType: UserType, data: Data, complition: @escaping (Int?) -> Void) {
        let urlRowValue = urlString + userType.rawValue + "/ValidateActivationCode"
        let url = URL(string: urlRowValue)!
        let request: URLRequest = {
            var request = URLRequest(url: url)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "POST"
            request.httpBody = data
            
            return request
        }()
        
        URLSession.shared.dataTask(with: request) { data, responce, error in
            guard let data = data else {
                print("No data recieved")
                return
            }
            let decoded = try? JSONDecoder().decode(ActivationCodeResponce.self, from: data)
            
            switch userType {
            case .driver:
                complition(decoded?.driverId)
            case .passenger:
                complition(decoded?.passengerId)
            }
        }.resume()
    }
    
    func completeRegistration(data: Data, complition: @escaping (Int?) -> Void) {
        let urlRowValue = urlString + "Passenger/CompleteRegistration"
        let url = URL(string: urlRowValue)!
        let request: URLRequest = {
            var request = URLRequest(url: url)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "POST"
            request.httpBody = data
            
            return request
        }()
        
        URLSession.shared.dataTask(with: request) { data, responce, error in
            guard let responce = responce as? HTTPURLResponse else {
                print("No data recieved")
                return
            }
            complition(responce.statusCode)
        }.resume()
    }
}
