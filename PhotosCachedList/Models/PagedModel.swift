//
//  PagedModel.swift
//  PhotosCachedList
//
//  Created by Ahmed Madeh on 14/08/2021.
//

import ObjectMapper

class PagedModel<T: Mappable>: Mappable {
    
    var items: [[T]] = []
    
    var nextPage: Int {
        return Int(items.flatMap({ $0 }).count / pageSize) + 1
    }
    var hasNextPage = true
    var pageSize = 10
    
    required init?(map: Map) {}
    
    init() {}
    
    func mapping(map: Map) {}
    
    func append(items: [T]) {
        self.hasNextPage = items.count == pageSize
        self.items.append(contentsOf: items.chunked(by: 5))
    }
    
}
