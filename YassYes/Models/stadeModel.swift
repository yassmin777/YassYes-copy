//
//  stadeModel.swift
//  YassYes
//
//  Created by Mac-Mini_2021 on 04/12/2021.
//

import Foundation
struct stadeModel:Encodable{
    internal init(_id: String, admin: adminModel? = nil, nom: String, lat: Double, lon: Double, discription: String) {
        self._id = _id
        self.admin = admin
        self.nom = nom
        self.lat = lat
        self.lon = lon
        self.discription = discription
    }
    
    //let photo:String?
    let _id:String
    let admin:adminModel?
    let nom:String
    let lat:Double
    let lon:Double
    //var capacity: Int
    let discription:String
}
