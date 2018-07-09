//
//  UIImage+.swift
//  OperationQueueSample
//
//  Created by shiz on 2018/07/08.
//  Copyright © 2018年 shiz. All rights reserved.
//

import UIKit

extension UIImage {
    
    func applySepiarFilter() -> UIImage? {
        
        guard let data = UIImagePNGRepresentation(self) else {
            return nil
        }
        let inputImage = CIImage(data: data)
        let context = CIContext(options: nil)
        
        guard let filter = CIFilter(name: "CISepiaTone") else {
            return nil
        }
        
        filter.setValue(inputImage, forKey: kCIInputImageKey)
        filter.setValue(0.8, forKey: "inputIntensity")
        
        guard let outputImage = filter.outputImage,
        let outImage = context.createCGImage(outputImage, from: outputImage.extent) else {
            return nil
        }
        return UIImage(cgImage: outImage)
    }
}
