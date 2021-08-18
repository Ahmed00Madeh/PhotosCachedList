//
//  PhotoModel.swift
//  PhotosCachedList
//
//  Created by Ahmed Madeh on 13/08/2021.
//

import ObjectMapper

class PhotoModel: Mappable {
    
    var id = 0
    var author = ""
    var width = 0
    var height = 0
    var url = ""
    var downloadUrl = ""
    var isAd = false
    
    required init?(map: Map) {}
    init() {}
    
    func mapping(map: Map) {
        id <- map["id"]
        author <- map["author"]
        width <- map["width"]
        height <- map["height"]
        url <- map["url"]
        downloadUrl <- map["download_url"]
    }

}
