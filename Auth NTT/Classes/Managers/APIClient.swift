//
//  APIClient.swift
//  AuthNTT
//
//  Created by Dodi Sitorus on 20/01/21.
//

import Foundation

import ObjectMapper
import Alamofire

enum JSONOption {
    case array
    case object
}

enum RequestOption {
    case post
    case get
}

class APIClient {
    
    var baseURL: URL?
    
    static let shared = { APIClient(baseUrl: APIManager.shared.baseURL) }()
    
    required init(baseUrl: String){
        self.baseURL = URL(string: baseUrl)
    }
    
    func requestWithFormData(urlString: String,
                        username: String,
                        password: String,
                        token: String?,
                        success: @escaping ([String: Any], Int) -> (),
                        failure: @escaping (Int) -> ()) {
        
        let parameters: [String: String] = ["username" : username, "password": password]
        
        
        var headers: HTTPHeaders = [
            "Content-type"  : "multipart/form-data"
        ]
        
        if token != nil {
            headers = [
                "Content-type"  : "multipart/form-data",
                "Authorization" : "Bearer \(token ?? "-")"
            ]
        }
        
        guard let url = NSURL(string: urlString , relativeTo: self.baseURL as URL?) else {
            return
        }
        
        let urlAPI = url.absoluteString!
        
        print(urlAPI)
        
        AF.upload(multipartFormData: { (formData) in
            
            if parameters.count != 0 {
                for (key, value) in parameters {
                    formData.append("\(value)".data(using: .utf8)!, withName: key)
                }
            }
            
        }, to: urlAPI, method: .post, headers: headers)
        .responseJSON { (json) in
            
            print("-------")
            print(json)
            
            if (json.error != nil) {
                
                failure(json.error?.responseCode ?? 0)
                
            } else if let jsonArray = json.value as? [String: Any] {
                
                let response: [String: Any] = jsonArray
                
                let status_code: Int = response["status_code"] as? Int ?? 0
                
                success(response, status_code)
            }
        }
    }
    
    func requestJsonArray(urlString: String,
                                 token: String?,
                                 method: String,
                                 body: [String: Any] = [:],
                                 success: @escaping ([[String: Any]], Int) -> (),
                                 failure: @escaping (Int) -> ()) {
        
        guard let url = NSURL(string: urlString , relativeTo: self.baseURL as URL?) else {
            return
        }
        
        var request = URLRequest(url: url as URL)
        request.httpMethod = method
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        if token != nil {
            request.addValue("Bearer \(token ?? "-")", forHTTPHeaderField: "Authorization")
        }
        
        if body.count != 0 {
            do {
                request.httpBody =  try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
            } catch let err {
                print(err)
            }
        }
        
        AF.request(request).validate().responseJSON { (response) in
            
            if response.error?.responseCode == 403 {
                
                let err: ErrorService = ErrorService(message: "", code: 403)
                
                failure(err.errorCode)
            }
            
            if let data = response.data {
                
                ConvertData.jsonFormat_V2(from: data) { (json) in
                    
                    if response.error != nil {
                        
                        if let JSON: [String: Any] = json?[0] {
                            
                            let errorJSON: [String: Any] = JSON["error"] as? [String: Any] ?? [:]
                            
                            let err: ErrorService = ErrorService(message: errorJSON["message"] as? String ?? "", code: errorJSON["status_code"] as? Int ?? 0)
                            
                            failure(err.errorCode)
                        }
                        
                    } else if let jsonArray = response.value as? [[String: Any]] {
                        success(jsonArray, 200)
                    } else {
                        success([], 400)
                    }
                }
            }
        }
        
    }
}
