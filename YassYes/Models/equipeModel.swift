//
//  equipeModel.swift
//  YassYes
//
//  Created by Mac-Mini_2021 on 27/11/2021.
//

import Foundation
struct equipeModel{
    internal init(
        image:String?=nil,
_id: String?=nil,
                  admin: adminModel? = nil,
                  nom: String?=nil,
                  discription: String?=nil,
                  joueurs_id:[joueurModel]? = nil,
                  win:Int?=nil,
                  lose:Int?=nil,
                  null:Int?=nil) {
        self.image = image
        self._id = _id
        self.admin = admin
        self.nom = nom
        self.discription = discription
        self.joueurs_id = joueurs_id
        self.win = win
        self.lose = lose
        self.null = null
    }
    let image:String?
    let _id:String?
    let admin:adminModel?
    let nom:String?
    //var capacity: Int
    let discription:String?
    let joueurs_id:[joueurModel]?
    let win:Int?
    let lose:Int?
    let null:Int?
}
