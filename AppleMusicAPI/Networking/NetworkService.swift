//
//  NetworkService.swift
//  AppleMusicAPI
//
//  Created by Mark on 12.03.2020.
//  Copyright © 2020 Mark. All rights reserved.
//

import Foundation
import UIKit

class NetworkService {
    
    func request(urlString:String, completion: @escaping (Result<SearchResponse,Error>) -> Void) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    print("Some error")
                    completion(.failure(error))
                    return
                }
                guard let data = data else { return }
                do {
                    let track = try JSONDecoder().decode(SearchResponse.self, from: data)
                    completion(.success(track))
                } catch  let jsonError {
                    print("Failed to decoded JSON", jsonError)
                    completion(.failure(jsonError))
                }
            }
        }.resume()
    }
    
    func getImage(from string: String) -> UIImage? {
        //2. Get valid URL
        guard let url = URL(string: string)
            else {
                print("Unable to create URL")
                return nil
        }

        var image: UIImage? = nil
        do {
            //3. Get valid data
            let data = try Data(contentsOf: url, options: [])

            //4. Make image
            image = UIImage(data: data)
        }
        catch {
            print(error.localizedDescription)
        }

        return image
    }
}
