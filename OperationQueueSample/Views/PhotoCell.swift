//
//  PhotoCell.swift
//  OperationQueueSample
//
//  Created by shiz on 2018/07/08.
//  Copyright © 2018年 shiz. All rights reserved.
//

import UIKit

class PhotoCell: UITableViewCell {

    static let identifier = "photo"
    
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var title: UILabel!
    
    var photoInfo: PhotoInfo? {
        didSet {
            guard let info = photoInfo else {
                return
            }
            title.text = info.title
            updateImageView(with: nil)
        }
    }
    
    func updateImageView(with image: UIImage?) {
        if let image = image {
            photo.image = image
            indicator.alpha = 0
            
            UIView.animate(withDuration: 0.3, animations: { [weak self] in
                self?.photo.alpha = 1.0
                self?.indicator.alpha = 0
            }, completion: { [weak self] _ in
                self?.indicator.stopAnimating()
            })
        } else {
            photo.image = nil
            photo.alpha = 0
            indicator.alpha = 1.0
            indicator.startAnimating()
        }
    }
}
