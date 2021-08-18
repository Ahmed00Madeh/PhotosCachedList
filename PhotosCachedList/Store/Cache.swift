//
//  Cache.swift
//  PhotosCachedList
//
//  Created by Ahmed Madeh on 17/08/2021.
//

import Foundation

final class Cache {
    private static func archiveUserInfo(info : Any) -> Data {
        return try! NSKeyedArchiver.archivedData(withRootObject: info, requiringSecureCoding: false)
    }
    
    static func object(key: String) -> Any? {
        if let unarchivedObject:  Data = UserDefaults.standard.object(forKey: key) as? Data{
            return try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(unarchivedObject)
        }
        return nil
    }
    
    static func set(object : Any, forKey key: String) {
        let archivedObject = archiveUserInfo(info: object)
        UserDefaults.standard.set(archivedObject, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    static func removeObject(key:String) {
        UserDefaults.standard.removeObject(forKey: key)
        UserDefaults.standard.synchronize()
    }
    
}
