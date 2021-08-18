//
//  DataLoader.swift
//  PhotosCachedList
//
//  Created by Ahmed Madeh on 18/08/2021.
//

import PromiseKit

protocol DataSource {
    func loadData() -> Promise<[PhotoModel]>
    func loadMoreData(page: Int) -> Promise<[PhotoModel]>?
}

class OnlineDataLoader: DataSource {
    func loadData() -> Promise<[PhotoModel]> {
        return API.getPhotosList(page: 0).map { items in
            CacheManager.cache(items)
            return items
        }
    }
    
    func loadMoreData(page: Int) -> Promise<[PhotoModel]>? {
        return API.getPhotosList(page: page)
    }
}

class OfflineDataLoader: DataSource {
    func loadData() -> Promise<[PhotoModel]> {
        return Promise.value(CacheManager.photos)
    }

    func loadMoreData(page: Int) -> Promise<[PhotoModel]>? {
        return nil
    }
}
