//
//  ligueModel.swift
//  YassYes
//
//  Created by Mac-Mini_2021 on 27/11/2021.
//


import Foundation
struct ligueModel{
    internal init(_id: String?=nil,
                  admin: adminModel? = nil,
                  nom: String?=nil,
                  discription: String?=nil,
                  equipes_ids:[equipeModel]? = nil,
                  matchs_id:[matchModel]? = nil) {
        self._id = _id
        self.admin = admin
        self.nom = nom
        self.discription = discription
        self.equipes_ids = equipes_ids
        self.matchs_id = matchs_id

    }
    let _id:String?
    let admin:adminModel?
    let nom:String?
    //var capacity: Int
    let discription:String?
    let equipes_ids:[equipeModel]?
    let matchs_id:[matchModel]?

}
