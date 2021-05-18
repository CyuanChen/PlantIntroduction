//
//  APIService.swift
//  TapeiPlant
//
//  Created by Peter Chen on 2021/5/9.
//

import Foundation

class APIService {
    
    func getData(completion: @escaping (Plants?) -> ()) {
        let urlString: String = "https://data.taipei/opendata/datalist/apiAccess?scope=resourceAquire&rid=f18de02f-b6c9-47c0-8cda-50efad621c14"
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        let urlRequest = URLRequest(url: url)
        let urlSession = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard let data = data, let plants = try? JSONDecoder().decode(Plants.self, from: data) else {
                completion(nil)
                return
            }
            completion(plants)
        }
        urlSession.resume()
    }
}
