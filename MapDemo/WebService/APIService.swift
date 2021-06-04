//
//  APIService.swift
//  TataMapDemo
//
//  Created by Kayaan Parikh on 03/06/20.
//  Copyright © 2021 Kayaan Parikh. All rights reserved.
//

import Foundation


class APIService :  NSObject {
    
    //private let sourcesURL = URL(string: "http://dummy.restapiexample.com/api/v1/employees")!
    private let sourcesURL = URL(string: "https://fake-poi-api.mytaxi.com/?p1Lat=18.910000&p1Lon=72.809998&p2Lat=18.5204&p2Lon=73.8567")!
    
    func apiToGetEmployeeData(completion : @escaping (Employees) -> ()){

        //readJson()

        URLSession.shared.dataTask(with: sourcesURL) { (data, urlResponse, error) in
            if let data = data {

                let jsonDecoder = JSONDecoder()

                let empData = try! jsonDecoder.decode(Employees.self, from: data)

                    completion(empData)
            }

        }.resume()
    }
    
    func apiToGetMapsData(completion : @escaping (MapModelData) -> ()){
        
        readJson()
        
        URLSession.shared.dataTask(with: sourcesURL) { (data, urlResponse, error) in
            if let data = data {

                let jsonDecoder = JSONDecoder()

                let empData = try! jsonDecoder.decode(MapModelData.self, from: data)

                    completion(empData)
            }

        }.resume()
    }
    
}


private func readJson() {
    do {
        if let file = Bundle.main.url(forResource: "DummyLatLong", withExtension: "json") {
            let data = try Data(contentsOf: file)
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            if let object = json as? [String: Any] {
                // json is a dictionary
                print(object)
            } else if let object = json as? [Any] {
                // json is an array
                print(object)
            } else {
                print("JSON is invalid")
            }
        } else {
            print("no file")
        }
    } catch {
        print(error.localizedDescription)
    }
}
