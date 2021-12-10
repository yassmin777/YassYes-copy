//
//  stadeModel.swift
//  YassYes
//
//  Created by Mac-Mini_2021 on 04/12/2021.
//

import Foundation
struct stadeModel{
    internal init(_id: String?=nil,
                  admin: adminModel? = nil,
                  image:String?=nil,
                  nom: String?=nil,
                  lat: Double?=nil,
                  lon: Double?=nil,
                  discription: String?=nil,
                  ligues_id: [ligueModel]?=nil
) {
        self._id = _id

        self.admin = admin
        self.image = image
        self.nom = nom
        self.lat = lat
        self.lon = lon
        self.discription = discription
        self.ligues_id = ligues_id
    }
    let _id:String?
    let admin:adminModel?
    let image:String?
    let nom:String?
    let lat:Double?
    let lon:Double?
    //var capacity: Int
    let discription:String?
    let ligues_id: [ligueModel]?
}
