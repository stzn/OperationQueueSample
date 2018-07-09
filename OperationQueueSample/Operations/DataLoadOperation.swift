//
//  DataLoadOperation.swift
//  OperationQueueSample
//
//  Created by shiz on 2018/07/08.
//  Copyright © 2018年 shiz. All rights reserved.
//

import Foundation

final class DataLoadOperation: AsyncOperation {
    
    private let url: URL
    private let completion: ((Data?) -> ())?
    private var loadedData: Data?
    
    init(url: URL, completion: ((Data?) -> ())? = nil) {
        self.url = url
        self.completion = completion
        super.init()
    }
    
    override func main() {
        if self.isCancelled {
            return
        }
        DummyNetwork.asyncLoadData(at: url) { data in
            
            if self.isCancelled {
                return
            }
            self.loadedData = data
            self.completion?(data)
            self.state = .Finished
        }
    }
}

extension DataLoadOperation: ImageDecompressionDataProvider {
    var compressedData: Data? {
        return loadedData
    }
}
