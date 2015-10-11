//
//  NSUserDefaultStorage.swift
//  Weather
//
//  Created by Heru Prasetia on 10/3/15.
//  Copyright © 2015 Heru Prasetia. All rights reserved.
//

// class handle to store to persistent storage or retrieve data from persistent storage

import Foundation

public class NSUserDefaultStorage: NSObject {
    // NSUserDefault
    var storage:NSUserDefaults;
    
    override init() {
        storage = NSUserDefaults.standardUserDefaults();
        super.init()
    }
    
    // function to store data to persistent storage
    public func storeData(keyword: String, arrayData: [String]) {
        storage.setObject(arrayData, forKey:keyword)
        storage.synchronize()
    }
    
    // function to retrieve data from persistent storage
    public func getData(keyword: String) -> [String] {
        let check = storage.objectForKey(keyword)
        if( check != nil) {
            let data:[String] = storage.objectForKey(keyword) as! NSArray as! [String]
            return data
        } else {
            return []
        }
    }
    
    public func getBundleData(keyword: String) -> Int {
        let check = storage.objectForKey(keyword)
        if check != nil {
            if (check as! String).characters.count > 0 {
                let x:Int = Int(check as! String)!
                return x
            } else {
                return 10
            }
        } else {
            return 10
        }
    }
    
    public func storeBundleData(keyword:String, num:String) {
        storage.setObject(num, forKey:keyword)
        storage.synchronize()
    }
    
    public func removeAllData(keyword: String) {
        self.storage.removeObjectForKey(keyword)
    }
}