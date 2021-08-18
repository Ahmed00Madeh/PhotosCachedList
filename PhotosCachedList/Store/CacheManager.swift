//
//  CacheManager.swift
//  PhotosCachedList
//
//  Created by Ahmed Madeh on 16/08/2021.
//

import ObjectMapper

class CacheManager {
    private static let maxCacheCount = 20
    @MapperCache(key: "photoCached") static var photos: [PhotoModel] = []
    
    static func cache(_ photos: [PhotoModel]) {
        self.photos = Array((Self.photos + photos).suffix(maxCacheCount))
    }
}

@propertyWrapper
struct MapperCache<T: Sequence> where T.Element: Mappable {
    private let key: String
    private let initialValue: T
    var wrappedValue: T {
        set {
            Cache.set(object: newValue.map({ $0.toJSON() }), forKey: key)
        }
        get {
            guard let array = Cache.object(key: key) as? [[String: Any]] else {
                return initialValue
            }
            return Mapper<T.Element>().mapArray(JSONArray: array) as? T ?? initialValue
        }
    }
    
    init(wrappedValue initialValue: T, key: String) {
        self.initialValue = initialValue
        self.key = key
    }
    
}
