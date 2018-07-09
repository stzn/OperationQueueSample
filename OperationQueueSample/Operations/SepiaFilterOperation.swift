//
//  SepiaFilterOperation.swift
//  OperationQueueSample
//
//  Created by shiz on 2018/07/08.
//  Copyright © 2018年 shiz. All rights reserved.
//

import Foundation

final class SepiaFilterOperation: ImageFilterOperation {
    
    override func main() {
        if isCancelled {
            return
        }
        guard let inputImage = filterInput else {
            return
        }
        if isCancelled {
            return
        }
        filterOutput = inputImage.applySepiarFilter()
    }
}
