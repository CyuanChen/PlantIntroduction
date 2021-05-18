//
//  ViewModel.swift
//  TapeiPlant
//
//  Created by Peter Chen on 2021/5/11.
//

import Foundation
class PlantViewModel {
    
    var plants: [Plant]?
    var page: Int = 1
    func getData(completion: @escaping (Bool) -> ()) {
        let urlString: String = "https://data.taipei/opendata/datalist/apiAccess?scope=resourceAquire&rid=f18de02f-b6c9-47c0-8cda-50efad621c14&limit=20&offset=\(self.page * 20)"
        guard let url = URL(string: urlString) else {
            completion(false)
            return
        }
        let urlRequest = URLRequest(url: url)
        let urlSession = URLSession.shared.dataTask(with: urlRequest) { [weak self] (data, response, error) in
            guard let data = data, let plants = try? JSONDecoder().decode(Plants.self, from: data) else {
                completion(false)
                return
            }
            if self?.plants == nil {
                self?.plants = plants.result.results
            } else {
                self?.plants?.append(contentsOf: plants.result.results)
            }
            completion(true)
            self?.page += 1
        }
        urlSession.resume()
    }
}
