//
//  matchModel.swift
//  YassYes
//
//  Created by Mac-Mini_2021 on 09/12/2021.
//

import Foundation
struct matchModel{
    internal init(_id: String?=nil,
                  admin: adminModel? = nil,
                  nom: String?=nil,
                  discription: String?=nil,
                  equipe_A_id:[equipeModel]? = nil,
                  equipe_B_id:[equipeModel]? = nil) {
        self._id = _id
        self.admin = admin
        self.nom = nom
        self.discription = discription
        self.equipe_A_id = equipe_A_id
        self.equipe_B_id = equipe_B_id

    }
    let _id:String?
    let admin:adminModel?
    let nom:String?
    //var capacity: Int
    let discription:String?
    let equipe_A_id:[equipeModel]?
    let equipe_B_id:[equipeModel]?

}
