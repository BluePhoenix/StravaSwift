//
//  SwiftyJSONRequest.swift
//  StravaSwift
//
//  Created by Matthew on 15/11/2015.
//  Copyright © 2015 Matthew Clarkson. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

//MARK: - Methods

extension Request {
    
    func responseStrava<T: Strava>(_ completionHandler: (Response<T, NSError>) -> Void) -> Self {
        return responseStrava(nil, keyPath: nil, completionHandler: completionHandler)
    }
    
    func responseStrava<T: Strava>(_ keyPath: String, completionHandler: (Response<T, NSError>) -> Void) -> Self {
        return responseStrava(nil, keyPath: keyPath, completionHandler: completionHandler)
    }
    
    func responseStrava<T: Strava>(_ queue: DispatchQueue?, keyPath: String?, completionHandler: (Response<T, NSError>) -> Void) -> Self {
        return response(queue: queue, responseSerializer: Request.StravaSerializer(keyPath), completionHandler: completionHandler)
    }
    
    func responseStravaArray<T: Strava>(_ completionHandler: (Response<[T], NSError>) -> Void) -> Self {
        return responseStravaArray(nil, keyPath: nil, completionHandler: completionHandler)
    }
    
    func responseStravaArray<T: Strava>(_ keyPath: String, completionHandler: (Response<[T], NSError>) -> Void) -> Self {
        return responseStravaArray(nil, keyPath: keyPath, completionHandler: completionHandler)
    }
    
    func responseStravaArray<T: Strava>(_ queue: DispatchQueue?, completionHandler: (Response<[T], NSError>) -> Void) -> Self {
        return responseStravaArray(queue, keyPath: nil, completionHandler: completionHandler)
    }
    
    func responseStravaArray<T: Strava>(_ queue: DispatchQueue?, keyPath: String?, completionHandler: (Response<[T], NSError>) -> Void) -> Self {
        return response(queue: queue, responseSerializer: Request.StravaArraySerializer(keyPath), completionHandler: completionHandler)
    }
}

//MARK: Serializers

//TODO: Clean these up so there is no duplication

extension Request {
    
    typealias SerializeResponse = (URLRequest?, HTTPURLResponse?, Data?, NSError?)
    
    fileprivate static func parseResponse(_ info: SerializeResponse) -> (Result<AnyObject,NSError>?, NSError?) {
        let (request, response, data, error) = info
        
        guard let _ = data else {
            let error = generateError("Data could not be serialized. Input data was nil.")
            return (nil, error)
        }
        
        let JSONResponseSerializer = Request.JSONResponseSerializer(options: .allowFragments)
        let result = JSONResponseSerializer.serializeResponse(request, response, data, error)
        
        return (result, nil)
    }
    
    fileprivate static func generateError(_ string: String) -> NSError {
        return Alamofire.Error.errorWithCode(.dataSerializationFailed, failureReason: string)
    }
    
    static func StravaSerializer<T: Strava>(_ keyPath: String?) -> ResponseSerializer<T, NSError> {
        return ResponseSerializer { request, response, data, error in
            let (result, e) = parseResponse(request, response, data, error)
            
            if let e = e {
                return .failure(e)
            }
            
            if let json = result?.value {
                let object = T.init(JSON(json))
                return .success(object)
            }

            return .failure(generateError("StravaSerializer failed to serialize response."))
        }
    }
    
    static func StravaArraySerializer<T: Strava>(_ keyPath: String?) -> ResponseSerializer<[T], NSError> {
        return ResponseSerializer { request, response, data, error in
            
            let (result, e) = parseResponse(request, response, data, error)
            
            if let e = e {
                return .failure(e)
            }
            
            if let json = result?.value {
                var results:[T] = []
                JSON(json).array?.forEach {
                    results.append(T.init($0))
                }
                
                return .success(results)
            }

            return .failure(generateError("StravaSerializer failed to serialize response."))
        }
    }
}
