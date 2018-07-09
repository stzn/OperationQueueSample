//
//  Compressor.swift
//  OperationQueueSample
//
//  Created by shiz on 2018/07/08.
//  Copyright © 2018年 shiz. All rights reserved.
//

import Foundation

struct Compressor {
    
    static func loadCompressedFile(_ path: String) -> Data? {
        return Data(contentsOfArchive: path, usedCompression: .lzma)
    }
    
    static func decompressData(_ data: Data) -> Data? {
        return data.uncompressed(using: .lzma)
    }
    
    static func saveDataAsCompressedFile(_ data: Data, path: String) -> Bool {
        guard let compressed = data.compressed(using: .lzma) else {
            return false
        }
        return ((try? compressed.write(to: URL(fileURLWithPath: path), options: [.atomic])) != nil)
    }
}

