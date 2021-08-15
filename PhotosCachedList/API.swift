//
//  API.swift
//  PhotosCachedList
//
//  Created by Ahmed Madeh on 14/08/2021.
//

import ESNetworkManager
import Alamofire
import PromiseKit

final class API {
    
    static func getPhotosList(page: Int) -> Promise<[PhotoModel]> {
        let request = ESNetworkRequest(base: Constants.baseUrl, path: "list")
        request.encoding = URLEncoding.default
        request.parameters = ["page": page,
                              "limit": "10"]
        return ESNetworkManager.execute(request: request)
    }

}
