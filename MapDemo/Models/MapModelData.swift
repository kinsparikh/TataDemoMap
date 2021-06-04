//
//  MapModelData.swift
//
//  Created by Kayaan on 03/06/21
//  Copyright (c) . All rights reserved.
//

import Foundation

struct MapModelData: Codable {

  enum CodingKeys: String, CodingKey {
    case poiList
  }

  var poiList: [PoiList]?

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    poiList = try container.decodeIfPresent([PoiList].self, forKey: .poiList)
  }

}

struct PoiList: Codable {

  enum CodingKeys: String, CodingKey {
    case coordinate
    case heading
    case id
    case fleetType
  }

  var coordinate: Coordinate?
  var heading: Float?
  var id: Int?
  var fleetType: String?

    
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    coordinate = try container.decodeIfPresent(Coordinate.self, forKey: .coordinate)
    heading = try container.decodeIfPresent(Float.self, forKey: .heading)
    id = try container.decodeIfPresent(Int.self, forKey: .id)
    fleetType = try container.decodeIfPresent(String.self, forKey: .fleetType)
  }

}


struct Coordinate: Codable {

  enum CodingKeys: String, CodingKey {
    case longitude
    case latitude
  }

  var longitude: Float?
  var latitude: Float?



  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    longitude = try container.decodeIfPresent(Float.self, forKey: .longitude)
    latitude = try container.decodeIfPresent(Float.self, forKey: .latitude)
  }

}
