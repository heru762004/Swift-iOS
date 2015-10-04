//
//  WeatherDataStorage.swift
//  Weather
//
//  Created by Heru Prasetia on 10/3/15.
//  Copyright © 2015 Heru Prasetia. All rights reserved.
//

import Foundation

// class to handle city name persistent storage

public class CityNameStorageHandler: NSObject {
    // object to handle persistent storage
    var dataStorage: NSUserDefaultStorage
    // keyword that used in persistent storage as identified key
    var keyword:String = "CityName";
    
    // initialization
    override public init() {
        self.dataStorage = NSUserDefaultStorage()
    }
    
    // check whether city name available
    public func isCityNameDataAvailable() -> Bool {
        var isAvailable:Bool = false
        if(self.dataStorage.getData(keyword).count > 0) {
            isAvailable = true
        }
        return isAvailable
    }
    
    // return number of city name on persistent storage
    public func cityNameDataCount() -> Int {
        return self.dataStorage.getData(keyword).count
    }
    
    // add and store city name to persistent storage
    public func addCityName(cityName: String) {
        // store the city name only if there is weather data
        var arrayData:[String] = getAllCitiesName()
        // maximum data store is 10, otherwise we should remove the old data
        if arrayData.count >= 10 {
            arrayData.removeFirst()
        }
        // filter whether there is a duplicate city name that already store in storage
        let findData = arrayData.filter() { $0 == cityName}
        if findData.count == 0 && cityName.characters.count > 0 {
            // if there is no duplicate data, just add it into array and store it to persistent storage
            arrayData.append(cityName);
        } else if findData.count > 0 && cityName.characters.count > 0 {
            // if there is a city name on the storage, we will remove the old data, and re-insert again
            arrayData = arrayData.filter() { $0 != cityName }
            arrayData.append(cityName)
        }
        self.dataStorage.storeData(keyword, arrayData: arrayData)
    }
    
    // return all city name from persistent storage
    public func getAllCitiesName() -> [String] {
        return self.dataStorage.getData(keyword)
    }
    
    public func removeAllCityNames() {
        self.dataStorage.removeAllData(keyword)
    }
}