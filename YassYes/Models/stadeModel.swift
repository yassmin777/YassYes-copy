//
//  stadeModel.swift
//  YassYes
//
//  Created by Mac-Mini_2021 on 04/12/2021.
//

import Foundation
struct stadeModel{
    internal init(image:String?=nil
                  ,_id: String?=nil,
                  admin: adminModel? = nil,
                  nom: String?=nil,
                  lat: Double?=nil,
                  lon: Double?=nil,
                  discription: String?=nil) {
        self.image = image
        self._id = _id
        self.admin = admin
        self.nom = nom
        self.lat = lat
        self.lon = lon
        self.discription = discription
    }
    
    let image:String?
    let _id:String?
    let admin:adminModel?
    let nom:String?
    let lat:Double?
    let lon:Double?
    //var capacity: Int
    let discription:String?
}
