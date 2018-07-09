//
//  SepiaImageProvider.swift
//  OperationQueueSample
//
//  Created by shiz on 2018/07/08.
//  Copyright © 2018年 shiz. All rights reserved.
//

import UIKit

final class SepiaImageProvider {
    
    private let operationQueue = OperationQueue()
    let photoInfo: PhotoInfo
    
    init(photoInfo: PhotoInfo, completion: @escaping (UIImage?) -> ()) {
        self.photoInfo = photoInfo
        
        let url = Bundle.main.url(forResource: photoInfo.name, withExtension: "compressed")!
        
        let dataLoad = DataLoadOperation(url: url)
        let decompress = ImageDecompressionOperation(data: nil)
        let sepiaFilter = SepiaFilterOperation(image: nil)
        let output = ImageFilterOutputOperation(completion: completion)
        
        let operations = [dataLoad, decompress, sepiaFilter, output]
        
        // 依存関係を設定
        decompress.addDependency(dataLoad)
        sepiaFilter.addDependency(decompress)
        output.addDependency(sepiaFilter)
        
        operationQueue.addOperations(operations, waitUntilFinished: false)
    }
    
    func suspend() {
        operationQueue.isSuspended = true
    }

    func resume() {
        operationQueue.isSuspended = false
    }

    func cancel() {
        operationQueue.cancelAllOperations()
    }
}


extension SepiaImageProvider: Hashable {
    static func == (lhs: SepiaImageProvider, rhs: SepiaImageProvider) -> Bool {
        return lhs.photoInfo == rhs.photoInfo
    }
    
    var hashValue: Int {
        return (photoInfo.title + photoInfo.name).hashValue
    }
}

