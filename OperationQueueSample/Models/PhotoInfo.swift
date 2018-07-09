//
//  PhotoInfo.swift
//  OperationQueueSample
//
//  Created by shiz on 2018/07/08.
//  Copyright © 2018年 shiz. All rights reserved.
//

import Foundation

struct PhotoInfo: Equatable {
    let name: String
    let title: String
}

extension PhotoInfo {
    static func loadData() -> [PhotoInfo] {
        return [
            PhotoInfo(name: "1", title: "Photo1"),
            PhotoInfo(name: "2", title: "Photo2"),
            PhotoInfo(name: "3", title: "Photo3"),
            PhotoInfo(name: "4", title: "Photo4"),
            PhotoInfo(name: "5", title: "Photo5"),
            PhotoInfo(name: "6", title: "Photo6"),
            PhotoInfo(name: "7", title: "Photo7"),
            PhotoInfo(name: "8", title: "Photo8"),
            PhotoInfo(name: "9", title: "Photo9"),
        ]
    }
}
