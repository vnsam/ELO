//
//  URLResponse+StatusCode.swift
//  ELO
//
//  Created by Narayanasamy, Vignesh on 5/6/18.
//  Copyright © 2018 Infinitum Inc. All rights reserved.
//

import Foundation

extension URLResponse {
    var statusCode: Int? {
        return (self as? HTTPURLResponse)?.statusCode
    }
}
