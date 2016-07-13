//
//  APIProtocol.swift
//  Gainsclaw
//
//  Created by Roberto Pando on 7/12/16.
//  Copyright © 2016 Aestheticruz. All rights reserved.
//

import Foundation


let ACNetworkError = "com.Aestheticruz.Gainsclaw"
let UnknownError = 10

typealias JSON = [String: AnyObject]
typealias JSONStructure = (JSON?, NSURLResponse?, NSError?) -> Void


protocol DictSetter {
    init?(dict: [String: AnyObject])
}

enum FetchResponse<T>{
    case Success(T)
    case Failure(ErrorType)
}


protocol APIGetter {
    var configuration: NSURLSessionConfiguration { get }
    var session: NSURLSession { get }
    
    func JSONDataTask(request: NSURLRequest, completion: JSONStructure) -> NSURLSessionDataTask
    func DataFetch<T>(request: NSURLRequest, parse: JSON->T?, completion: FetchResponse<T> -> Void)
}


extension APIGetter {
    
    func JSONDataTask(request: NSURLRequest, completion: JSONStructure) -> NSURLSessionDataTask {
        let task = session.dataTaskWithRequest(request) { data, response, error in
            
            guard let HTTPResponse = response as? NSHTTPURLResponse else {
                return
            }
            if data == nil {
                if let error = error {
                    completion(nil, HTTPResponse, error)
                }
            }else {
                switch HTTPResponse.statusCode {
                case 200: do {
                    let json = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? [String: AnyObject]
                    completion(json, HTTPResponse, nil)
                }catch let error as NSError {
                    completion(nil, HTTPResponse, error)
                    }
                default: print("\(HTTPResponse.statusCode)")
                }
            }
            
        }
        return task
        
    }
    
    func DataFetch<T>(request: NSURLRequest, parse: JSON->T?, completion: FetchResponse<T> -> Void) {
        let task = JSONDataTask(request) { json, response, error in
            
            guard let json = json else {
                if let error = error {
                    completion(.Failure(error))
                } else {
                    //TODO: Error handle
                }
                return
            }
            
            if let value = parse(json) {
                completion(.Success(value))
            } else {
                let error = NSError(domain: ACNetworkError, code: UnknownError, userInfo: nil)
                completion(.Failure(error))
            }
        }
        task.resume()
    }

    
}

















