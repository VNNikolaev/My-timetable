//
//  NetworkService.swift
//  My timetable
//
//  Created by Васлий Николаев on 17.02.2020.
//  Copyright © 2020 Васлий Николаев. All rights reserved.
//

import Foundation
import Alamofire

class NetworkService {
    
    func fetchData(urlString: String, completion: @escaping (Result<[Training]>) -> Void) {
        guard let url = URL(string: urlString) else { return }
        request(url).validate().responseData { (dataResponse) in
            
            switch dataResponse.result{
            case .failure(let error):
                print(error)
                completion(.failure(error))
                return
                
            case .success(let value):
                do {
                    let trainig = try JSONDecoder().decode([Training].self, from: value)
                    completion(.success(trainig))
                    
                } catch let jsonError {
                    print("Failed to decode JSON", jsonError)
                    completion(.failure(jsonError))
                }
            }
        }
    }
}
