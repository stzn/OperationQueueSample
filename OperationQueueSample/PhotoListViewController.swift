//
//  ViewController.swift
//  OperationQueueSample
//
//  Created by shiz on 2018/07/08.
//  Copyright © 2018年 shiz. All rights reserved.
//

import UIKit

class PhotoListViewController: UITableViewController {
    
    var photoList: [PhotoInfo] = PhotoInfo.loadData()
    var providers = Set<SepiaImageProvider>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 355
    }
}

extension PhotoListViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photoList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PhotoCell.identifier, for: indexPath) as? PhotoCell else {
            fatalError("invalid cell")
        }
        let info = photoList[indexPath.row]
        cell.photoInfo = info
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? PhotoCell else {
            return
        }
        let provider = SepiaImageProvider(photoInfo: photoList[indexPath.row]) { image in
            DispatchQueue.main.async {
                cell.updateImageView(with: image)
            }
        }
        providers.insert(provider)
    }
    
    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = cell as? PhotoCell else {
            return
        }
        guard let provider = providers.first(where: { $0.photoInfo == cell.photoInfo }) else {
            return
        }
        provider.cancel()
        providers.remove(provider)
    }
}


// FIXME: 読み込みが遅い(ロジックの見直し)

//// MARK: - scrollview delegate
//
//extension PhotoListViewController {
//
//    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
//        suspendAllOperations()
//    }
//
//    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//        if !decelerate {
//            loadImagesForOnscreenCells()
//            resumeAllOperations()
//        }
//    }
//
//    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        loadImagesForOnscreenCells()
//        resumeAllOperations()
//    }
//}
//
//extension PhotoListViewController {
//
//    func suspendAllOperations() {
//        providers.forEach { $0.suspend() }
//    }
//
//    func resumeAllOperations() {
//        providers.forEach { $0.resume() }
//    }
//
//    func loadImagesForOnscreenCells() {
//
//        guard let pathsArray = self.tableView.indexPathsForVisibleRows else {
//            return
//        }
//
//        DispatchQueue.global(qos: .userInitiated).async {
//
//            let visibleList = self.photoList.enumerated().filter { i, _ in pathsArray.contains(IndexPath(row: i, section: 0))
//            }
//
//            let visibleProviders = self.providers.filter { visibleList.map{$1}.contains($0.photoInfo) }
//            let cancelProviders = self.providers.subtracting(visibleProviders)
//            cancelProviders.forEach { $0.cancel() }
//
//            var newSet = self.providers.subtracting(visibleProviders)
//
//            visibleList.map{$1}.forEach { photoInfo in
//
//                let provider = SepiaImageProvider(photoInfo: photoInfo) { image in
//
//                    guard let index = visibleList.index(where: { _, info in info == photoInfo}) else {
//                        return
//                    }
//                    DispatchQueue.main.async {
//                        guard let cell = self.tableView.cellForRow(at: IndexPath(row: index, section: 0)) as? PhotoCell else {
//                            return
//                        }
//
//                        cell.updateImageView(with: image)
//                    }
//                }
//                newSet.insert(provider)
//            }
//            self.providers = newSet
//        }
//    }
//}


