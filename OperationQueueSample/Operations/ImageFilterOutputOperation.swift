//
//  ImageFilterOutputOperation.swift
//  OperationQueueSample
//
//  Created by shiz on 2018/07/08.
//  Copyright © 2018年 shiz. All rights reserved.
//

import UIKit

final class ImageFilterOutputOperation: ImageFilterOperation {
    
    private let completion: (UIImage?) -> ()
    
    init(completion: @escaping (UIImage?) -> ()) {
        self.completion = completion
        super.init(image: nil)
    }
    override func main() {
        if isCancelled {
            return
        }
        completion(filterInput)
    }
}
