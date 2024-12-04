//
//  APICaller.swift
//  SocialOTT
//
//  Created by AbdulMajid Shaikh on 01/12/24.
//

import Foundation
import Alamofire

public class APICaller
{
    
     static func getRequest<T:Decodable>(url:String, modalName:T.Type,completion:@escaping (T?,Error?, Int) -> Void)

    {
        print("ApiUrl:-", url)
           let request = NSMutableURLRequest(url: URL(string: url)!,  cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
            
            request.httpMethod = "GET"
            request.addValue("Bearer \(NetworkConstant.shared.token)", forHTTPHeaderField: "Authorization")

            let task = URLSession.shared.dataTask(with: request as URLRequest){(data,response,error) in
                DispatchQueue.main.async
                {
                
                guard let data = data else
                    {
                    print(String(describing: error))
                    return completion(nil, error, 0)
                }
                print(String(data: data, encoding: .utf8)!)
                
                do
                {
                    let json = try JSONDecoder().decode(modalName.self, from: data)
                    completion(json,nil, 1)
                    
                }catch let jsonerr
                    {
                    print("error-:\(jsonerr.localizedDescription)")
                    completion(nil,jsonerr, 0)
                }
                    
                }
            }
            
            task.resume()
    }
    

}
