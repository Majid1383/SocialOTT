//
//  APIRequest.swift
//  SocialOTT
//
//  Created by AbdulMajid Shaikh on 02/12/24.
//

import Foundation


//MARK: Network Errors
enum NetworkError: Error
{
    case invalidURLError
    case parsingError
    case networkError
    case jsonDecodingError
}


class APIRequest
{
    //MARK: Generic GET Request
    static func getRequest<T: Decodable>(url: String, modalName: T.Type, completion: @escaping (T?, NetworkError?, Int) -> Void) {
        print("ApiUrl:-", url)
        let request = NSMutableURLRequest(url: URL(string: url)!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        
        request.httpMethod = "GET"
        request.addValue("Bearer \(NetworkConstant.shared.token)", forHTTPHeaderField: "Authorization")

        let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data else {
                    print(String(describing: error))
                    return completion(nil, .parsingError, 0)
                }
                
                print(String(data: data, encoding: .utf8)!)
                
                do {
                    let json = try JSONDecoder().decode(modalName.self, from: data)
                    completion(json, nil, 1) // Return the decoded model
                } catch let jsonError {
                    print("Error decoding: \(jsonError.localizedDescription)")
                    completion(nil, .jsonDecodingError, 0) // Return error if decoding fails
                }
            }
        }
        
        task.resume()
    }
    
    static func fetchMovieTrailers(movieId: Int, completion: @escaping (Result<[Trailer], NetworkError>) -> Void) {
            let url = "\(NetworkConstant.shared.baseUrl)/movie/\(movieId)/videos?api_key=\(NetworkConstant.shared.apiKey)"
            
            guard let requestURL = URL(string: url) else {
                completion(.failure(.invalidURLError))
                return
            }
            
            URLSession.shared.dataTask(with: requestURL) { data, response, error in
                if let error = error {
                    completion(.failure(error as! NetworkError))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(.parsingError))
                    return
                }
                
                do {
                    let decodedResponse = try JSONDecoder().decode(TrailerResponse.self, from: data)
                    let youtubeTrailers = decodedResponse.results.filter { $0.site.lowercased() == "youtube" }
                    completion(.success(youtubeTrailers))
                } catch {
                    completion(.failure(.networkError))
                }
            }.resume()
        }
    
    
}
