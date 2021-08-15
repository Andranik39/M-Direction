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
    
    enum RequestType: String {
        case passengerLoginRequest = "Passenger/Login"
        case driverLoginRequest = "Driver/Login"
        case passengerSendActivationCodeRequest = "Passenger/SendActivationCode"
        case driverSendActivationCodeRequest = "Driver/SendActivationCode"
        
//        case registerDriverFirstStageRequest = "Driver/DriverFirstStage"
        case registerDriverSecondStageRequest = "Driver/DriverSecondStage"
        case registerDriverThirdStageRequest = "Driver/RegisterDriverThirdStage"
        case registerDriverFourthStageRequest = "Driver/RegisterDriverFourthStage"
    }
    
//    func singIn(_ userType: UserType, data: Data, complition: @escaping (Int?) -> Void) {
//        let urlRowValue = urlString + userType.rawValue + "/Login"
//        let url = URL(string: urlRowValue)!
//        let request: URLRequest = {
//            var request = URLRequest(url: url)
//            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//            request.httpMethod = "POST"
//            request.httpBody = data
//
//            return request
//        }()
//
//        URLSession.shared.dataTask(with: request) { data, responce, error in
//            guard let responce = responce as? HTTPURLResponse else {
//                print("No data recieved")
//                return
//            }
//            complition(responce.statusCode)
//        }.resume()
//    }
    
//    func sendActivationCode(_ userType: UserType, data: Data, complition: @escaping (Int?) -> Void) {
//        let urlRowValue = urlString + userType.rawValue + "/SendActivationCode"
//        let url = URL(string: urlRowValue)!
//        let request: URLRequest = {
//            var request = URLRequest(url: url)
//            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//            request.httpMethod = "POST"
//            request.httpBody = data
//
//            return request
//        }()
//
//        URLSession.shared.dataTask(with: request) { data, responce, error in
//            guard let responce = responce as? HTTPURLResponse else {
//                print("No data recieved")
//                return
//            }
//            complition(responce.statusCode)
//        }.resume()
//    }
    
    func validateActivationCode(_ userType: UserType, data: Data, complition: @escaping (Int?) -> Void) {
        let destination = userType == .driver ? "Driver/DriverFirstStage": "Passenger/Registration"
        let urlRowValue = urlString + destination
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
                complition(nil)
            }
        }.resume()
    }
    
//    func completeRegistration(data: Data, complition: @escaping (Int?) -> Void) {
//        let urlRowValue = urlString + "Passenger/CompleteRegistration"
//        let url = URL(string: urlRowValue)!
//        let request: URLRequest = {
//            var request = URLRequest(url: url)
//            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//            request.httpMethod = "POST"
//            request.httpBody = data
//
//            return request
//        }()
//
//        URLSession.shared.dataTask(with: request) { data, responce, error in
//            guard let responce = responce as? HTTPURLResponse else {
//                print("No data recieved")
//                return
//            }
//            complition(responce.statusCode)
//        }.resume()
//    }
    
    func post(data: Data, as networkRequest: RequestType, complition: @escaping (Int?) -> Void) {
        let urlRowValue = urlString + networkRequest.rawValue
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
    
//    func registerDriverFirstStage(data: Data, complition: @escaping (Int?) -> Void) {
//        let urlRowValue = urlString + "Driver/RegisterDriverFirstStage"
//        let url = URL(string: urlRowValue)!
//        let request: URLRequest = {
//            var request = URLRequest(url: url)
//            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//            request.httpMethod = "POST"
//            request.httpBody = data
//
//            return request
//        }()
//
//        URLSession.shared.dataTask(with: request) { data, responce, error in
//            guard let responce = responce as? HTTPURLResponse else {
//                print("No data recieved")
//                return
//            }
//            complition(responce.statusCode)
//        }.resume()
//    }
//
//    func registerDriverSecondStage(data: Data, complition: @escaping (Int?) -> Void) {
//        let urlRowValue = urlString + "Driver/RegisterDriverSecondStage"
//        let url = URL(string: urlRowValue)!
//        let request: URLRequest = {
//            var request = URLRequest(url: url)
//            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//            request.httpMethod = "POST"
//            request.httpBody = data
//
//            return request
//        }()
//
//        URLSession.shared.dataTask(with: request) { data, responce, error in
//            guard let responce = responce as? HTTPURLResponse else {
//                print("No data recieved")
//                return
//            }
//            complition(responce.statusCode)
//        }.resume()
//    }
    
    enum GetRequestType: String {
        case getMarks = "Cars/GetMarks"
        case getModelNamesByMark = "Cars/GetModelNamesByMark"
        case getColors = "Cars/GetColors"
    }
    
    struct RequestParameter {
        let key: String
        let value: String
    }
    
    func get<T: Decodable>(as networkRequest: GetRequestType, headers: [RequestParameter] = [], query parameters: [RequestParameter] = [], complition: @escaping (T) -> Void) {
        var urlRowValue = urlString + networkRequest.rawValue
        
        if !parameters.isEmpty {
            urlRowValue += "?\(parameters[0].key)=\(parameters[0].value)"
            
            for parameter in parameters[1...] {
                urlRowValue += "+\(parameter.key)=\(parameter.value)"
            }
        }
        
        let url = URL(string: urlRowValue)!
        let request: URLRequest = {
            var request = URLRequest(url: url)
            
            for parameter in headers {
                request.setValue(parameter.value, forHTTPHeaderField: parameter.key)
            }
            
            return request
        }()
        
        URLSession.shared.dataTask(with: request) { data, responce, error in
            guard let responce = responce as? HTTPURLResponse, responce.statusCode == 200 else {
                print("No data recieved, or there is an error")
                return
            }
            if let data = data, let decoded = try? JSONDecoder().decode(T.self, from: data) {
                complition(decoded)
            }
        }.resume()
    }
}
