//
//  NetworkRequest.swift
//  TopAlbums
//
//  Created by Jason Maxwell Custodio on 3/15/20.
//  Copyright © 2020 Jason Maxwell Custodio. All rights reserved.
//

import Foundation

final class NetworkRequest {
    private let session = URLSession(configuration: .default, delegate: nil, delegateQueue: .main)
    private let url: URL
    
    init(url: URL) {
        self.url = url
    }
    
    func execute(withCompletion completion: @escaping (Data?) -> Void) {
        let task = session.dataTask(with: url) { data, response, error in
            if let e = error {
                print(e)
                return
            }
            
            completion(data)
        }
        task.resume()
    }
}

