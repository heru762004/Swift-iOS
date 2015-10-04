//
//  DataParser.swift
//  Weather
//
//  Created by Heru Prasetia on 10/2/15.
//  Copyright © 2015 Heru Prasetia. All rights reserved.
//

// master class to handle data parser
// if there is another data parser type with different behaviour, just need to re-implement the child of this class and override parse function

import Foundation

public class DataParser: NSObject {
    
    public func parse(input: NSData) -> ResponseData {
        return ResponseData();
    }
}
