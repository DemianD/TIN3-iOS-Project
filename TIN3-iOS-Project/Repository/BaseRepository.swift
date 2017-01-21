//
//  BaseRepository.swift
//  TIN3-iOS-Project
//
//  Created by Demian Dekoninck on 21/01/17.
//  Copyright © 2017 Demian Dekoninck. All rights reserved.
//


// Escape and why: http://stackoverflow.com/questions/38990882/closure-use-of-non-escaping-parameter-may-allow-it-to-escape

import Foundation
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

class BaseRepository<T : Mappable> {
    
    internal let urlSuffix: String
    internal var models = [T]()
    
    init(_ urlSuffix : String) {
        self.urlSuffix = urlSuffix
    }
    
    func all(withRefresh refresh: Bool = false, handler: @escaping ([T]) -> Void) {
        if !models.isEmpty && !refresh {
            handler(models)
        }
        
        fetchArray() {
            self.models = $0
            handler($0)
        }
    }
    
    func find(_ id : Int, handler: @escaping (T) -> Void) {
        Alamofire.request(getUrl(id)).responseObject(keyPath: Api.data) { (response: DataResponse<T>) -> Void in
            if let model = response.result.value {
                handler(model);
            }
        }
    }
    
    func save(_ model: T, handler: @escaping (T) -> Void) {
        Alamofire.request(getUrl(), method: .post, parameters: model.toJSON(), encoding: JSONEncoding.default).responseObject(keyPath: Api.data) { (response: DataResponse<T>) -> Void in
            
            if let model = response.result.value {
                handler(model);
            }
        }
    }
    
    func delete(_ model: T, handler: @escaping () -> Void) {
        Alamofire.request(getUrl(), method: .delete, parameters: model.toJSON(), encoding: JSONEncoding.default).responseObject(keyPath: Api.data) { (response: DataResponse<T>) -> Void in
            handler()
        }
    }
    
    func fetchArray(handler: @escaping ([T]) -> Void) {
        Alamofire.request(getUrl()).responseArray(keyPath: Api.data) { (response: DataResponse<[T]>) -> Void in
            if let modelsArray = response.result.value {
                handler(modelsArray);
            }
        }
    }
    
    func getUrl(_ suffix : Any? = nil) -> String {
        var requestUrl = Api.url
        
        print(String(describing: suffix))
        
        requestUrl = requestUrl.appending(urlSuffix)
        
        
        if let uSuffix = suffix {
            requestUrl = requestUrl.appending("/").appending(String(describing: uSuffix))
        }
        
        print(requestUrl)
        
        return requestUrl
    }
}
