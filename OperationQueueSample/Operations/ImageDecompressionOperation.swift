//
//  ImageDecompressionOperation.swift
//  OperationQueueSample
//
//  Created by shiz on 2018/07/08.
//  Copyright © 2018年 shiz. All rights reserved.
//

import UIKit

protocol ImageDecompressionDataProvider {
    var compressedData: Data? { get }
}

final class ImageDecompressionOperation: Operation {
    
    private let inputData: Data?
    private let completion: ((UIImage?) -> ())?
    private var outputImage: UIImage?
    
    init(data: Data?, completion: ((UIImage?) -> ())? = nil) {
        inputData = data
        self.completion = completion
        super.init()
    }
    
    override func main() {
        let compressedData: Data?
        if self.isCancelled {
            return
        }
        if let inputData = inputData {
            compressedData = inputData
        } else {
            
            let provider = dependencies
                .filter({ $0 is ImageDecompressionDataProvider })
                .first as? ImageDecompressionDataProvider
            compressedData = provider?.compressedData
        }
        
        guard let data = compressedData else {
            return
        }
        
        if self.isCancelled {
            return
        }
        
        if let decompressedData = Compressor.decompressData(data) {
            outputImage = UIImage(data: decompressedData)
        }
        
        if self.isCancelled {
            return
        }
        completion?(outputImage)
    }
}

extension ImageDecompressionOperation: ImageFilterDataProvider {
    var image: UIImage? {
        return outputImage
    }
}

