//
//  MapsDataSource.swift
//  TataMapDemo
//
//  Created by Kayaan on 03/06/21.
//  Copyright © 2021 Abhilash Mathur. All rights reserved.
//

import Foundation
import GoogleMaps

class MapViewDataSource<T> : NSObject {
    private var items : T!
    var configureMap : (T) -> () = {_ in }
    
    init(items : T, configureMap : @escaping (T) -> ()) {
        
        self.items =  items
        self.configureMap = configureMap
    }
    
    
}
