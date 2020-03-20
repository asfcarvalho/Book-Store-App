//
//  APICalling.swift
//  Book-Store-App
//
//  Created by Anderson F Carvalho on 04/03/20.
//  Copyright © 2020 Anderson F Carvalho. All rights reserved.
//

import Foundation

enum Err: Error {
    case Default
}

class APICalling<T: Codable> {
    typealias Callback = (Result<T, Error>) -> Void
    
    func fetch(apiRequest: APIRequest, callBack: @escaping Callback) {
        
        let request = apiRequest.request(with: apiRequest.baseURL)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let data = data, error == nil else {
                callBack(.failure(error ?? Err.Default))
                return
                
            }
            
            do {
                let model = try JSONDecoder().decode(T.self, from: data)
                callBack(.success(model))
                
            } catch let error {
                callBack(.failure(error))
            }
            
        }
        task.resume()
        
    }
}
