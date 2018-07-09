//
//  ImageFilterOperation.swift
//  OperationQueueSample
//
//  Created by shiz on 2018/07/08.
//  Copyright © 2018年 shiz. All rights reserved.
//

import UIKit

protocol ImageFilterDataProvider {
    var image: UIImage? { get }
}

class ImageFilterOperation: Operation {
    
    var filterOutput: UIImage?
    private let _filterInput: UIImage?
    
    init(image: UIImage?) {
        _filterInput = image
        super.init()
    }
    
    var filterInput: UIImage? {
        var image: UIImage?
        if let i = _filterInput {
            image = i
        } else if let provider = dependencies.filter({ $0 is ImageFilterDataProvider }).first as? ImageFilterDataProvider {
            image = provider.image
        }
        return image
    }
}

extension ImageFilterOperation: ImageFilterDataProvider {
    var image: UIImage? {
        return filterOutput
    }
}
