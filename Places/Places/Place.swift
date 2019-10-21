//
//  Place.swift
//  Places
//
//  Created by Shubhang Dixit on 21/10/19.
//  Copyright © 2019 Shubhang. All rights reserved.
//

import Foundation
class Place {
    let id, title: String?
    let latitude, longitude: Double?
    let imageURL: String?
    let description : String?

    enum CodingKeys: String {
        case id, title, latitude, longitude
        case imageURL = "imageUrl"
        case description = "description"
    }
    
    init(withDictionary dic : [String : Any]) {
        id = dic[CodingKeys.id.rawValue] as? String
        title = dic[CodingKeys.title.rawValue] as? String
        latitude = dic[CodingKeys.latitude.rawValue] as? Double
        longitude = dic[CodingKeys.longitude.rawValue] as? Double
        imageURL = dic[CodingKeys.imageURL.rawValue] as? String
        description = dic[CodingKeys.description.rawValue] as? String
    }

    init(id: String, title: String, latitude: Double, longitude: Double, imageURL: String?, description : String?) {
        self.id = id
        self.title = title
        self.latitude = latitude
        self.longitude = longitude
        self.imageURL = imageURL
        self.description = description
    }
    
    class func getDictionaryForPlace(withTitle title: String, description :String?, imageUrl: String?, latitude : Double, longitute: Double) -> [String : Any] {
        var placeDictionary : [String:Any] = [:]
        placeDictionary[CodingKeys.title.rawValue] = title
        placeDictionary[CodingKeys.longitude.rawValue] = longitute
        placeDictionary[CodingKeys.latitude.rawValue] = latitude
        if let imageurl = imageUrl {
            placeDictionary[CodingKeys.imageURL.rawValue] = imageurl
        }
        if let descr = description {
            placeDictionary[CodingKeys.description.rawValue] = descr
        }
        return placeDictionary
    }

}
