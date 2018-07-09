//
//  DummyNetwork.swift
//  OperationQueueSample
//
//  Created by shiz on 2018/07/08.
//  Copyright © 2018年 shiz. All rights reserved.
//

import Foundation

struct DummyNetwork {
    
    static func asyncLoadData(at url: URL, completion: @escaping (Data?) -> Void) {
        
        DispatchQueue.global().async {
            let data = syncLoadData(at: url)
            DispatchQueue.main.async {
                completion(data)
            }
        }
    }
    
    static func syncLoadData(at url: URL) -> Data? {
        let random = arc4random_uniform(2 * 1000000)
        usleep(random)
        return (try? Data(contentsOf: url))
    }
}
