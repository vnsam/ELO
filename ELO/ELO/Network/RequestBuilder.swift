//
//  RequestBuilder.swift
//  ELO
//
//  Created by Narayanasamy, Vignesh on 5/10/18.
//  Copyright © 2018 Infinitum Inc. All rights reserved.
//

import Foundation

class RequestBuilder {
    class func getRequestWithAddress(_ address: String, httpMethod: String,
                                     httpBody: Data? = nil,
                                     headerParameters: [String: String]? = nil) -> URLRequest? {
     
        if let url = URL(string: address) {
            var request = URLRequest.init(url: url)
            
            request.timeoutInterval = Constants.Network.timeoutInterval
            
            request.httpMethod = httpMethod
            
            request.httpBody = httpBody
            
            nil != headerParameters ? setParametersToRequest(&request,
                headerParameters: headerParameters!)
                : debugPrint("Empty header parameters")
            
            return request
        }
        
        return nil
    }
    
    class func setParametersToRequest(_ request: inout URLRequest,
                                      headerParameters: [String: String]) {
        for key in headerParameters.keys {
            if let value = headerParameters[key] {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
    }
}
