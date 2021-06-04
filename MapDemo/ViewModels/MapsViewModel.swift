//
//  MapsViewModel.swift
//  TataMapDemo
//
//  Created by Kayaan on 03/06/21.
//  Copyright © 2021 Abhilash Mathur. All rights reserved.
//

import Foundation

class MapsViewModel : NSObject {
    
    private var apiService : APIService!
    private(set) var mapsData : MapModelData! {
        didSet {
            self.bindMapsViewModelToController()
        }
    }
    
    var bindMapsViewModelToController : (() -> ()) = {}
    
    override init() {
        super.init()
        self.apiService =  APIService()
        callFuncToGetMapsData()
    }
    
    func callFuncToGetMapsData() {
        self.apiService.apiToGetMapsData { (mapsData) in
            self.mapsData = mapsData
        }
    }
}
