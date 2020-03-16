//
//  NetworkRequest.swift
//  TopAlbums
//
//  Created by Jason Maxwell Custodio on 3/15/20.
//  Copyright © 2020 Jason Maxwell Custodio. All rights reserved.
//

import Foundation

class NetworkRequest {
    let session = URLSession(configuration: .ephemeral, delegate: nil, delegateQueue: .main)
    let url: URL
    
    init(url: URL) {
        self.url = url
    }
    
    func execute(withCompletion completion: @escaping (Data?) -> Void) {
        let task = session.dataTask(with: url, completionHandler: { (data: Data?, _, _) -> Void in
            completion(data)
        })
        task.resume()
    }
}

