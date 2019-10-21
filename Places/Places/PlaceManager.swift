//
//  PlaceManager.swift
//  Places
//
//  Created by Shubhang Dixit on 21/10/19.
//  Copyright © 2019 Shubhang. All rights reserved.
//

import Foundation

class PlaceManager {
    static let shared = PlaceManager()
    var places : [Place] = []
    var dataDidChange = false
    
    func fetchPlaces(success: @escaping () -> Void, failure: @escaping (Error?)-> Void) {
        NetworkManager.shared.getPlacesList(success: {[weak self] data in
            do {
                if let parsedData = try JSONSerialization.jsonObject(with: data!) as?
                    [[String:Any]] {
                    for pData in parsedData {
                        self?.places.append(Place.init(withDictionary: pData))
                    }
                    success()
                } else {
                    failure(nil)
                }
            } catch let error as NSError {
                failure(error)
            }
        }) { error in
            failure(error)
        }
    }
    
    func fetchPlaceDetails(forPlace place: Place, success: @escaping (Place) -> Void, failure: @escaping (Error?)-> Void) {
        guard let iD = place.id, let placeID = Int(iD) else {
            failure(nil)
            return
        }
        NetworkManager.shared.getPlaceDetail(forID: placeID, success: { data in
            do {
                if let parsedData = try JSONSerialization.jsonObject(with: data!) as? [String:Any] {
                    let newPlace = Place.init(withDictionary: parsedData)
                    success(newPlace)
                } else {
                    failure(nil)
                }
            } catch let error as NSError {
                failure(error)
            }
        }) { error in
            failure(error)
        }
    }
    
    func saveNewPlace(withFirstName title: String, description :String?, imageUrl: String?, longitute : Double, latitute : Double, success: @escaping () -> Void, failure: @escaping (Error?)-> Void) {
        let placeDictionary = Place.getDictionaryForPlace(withTitle: title, description: description, imageUrl: imageUrl, latitude: latitute, longitute: longitute)
        NetworkManager.shared.postAPlace(withData: placeDictionary, success: {[weak self] data in
            do {
                if let parsedData = try JSONSerialization.jsonObject(with: data!) as? [String:Any] {
                    self?.addNewPlaceToDS(withData: parsedData)
                    self?.dataDidChange = true
                    success()
                } else {
                    failure(nil)
                }
            } catch let error as NSError {
                failure(error)
            }
            success()
        }) { error in
            failure(error)
        }
    }
    
    func saveChanges(forPlaceID iD : Int, data : [String : Any], success: @escaping () -> Void, failure: @escaping (Error?)-> Void) {
            NetworkManager.shared.updatePlace(forID: iD, withData: data, success: {[weak self] data in
                do {
                    if let parsedData = try JSONSerialization.jsonObject(with: data!) as? [String:Any] {
                        
                        success()
                    } else {
                        failure(nil)
                    }
                } catch let error as NSError {
                    failure(error)
                }
                success()
            }) { error in
                failure(error)
            }
        
    }
    
    func addNewPlaceToDS(withData place:[String:Any]) {
        let newPlace = Place.init(withDictionary: place)
        self.places.append(newPlace)
    }
}
