//
//  equipeModel.swift
//  YassYes
//
//  Created by Mac-Mini_2021 on 27/11/2021.
//

import Foundation
struct equipeModel{
    internal init(_id: String?=nil,

        image:String?=nil,
                  admin: adminModel? = nil,
                  nom: String?=nil,
                  discription: String?=nil,
                  joueurs_id:[joueurModel]? = nil,
                  point:Int?=nil,
                  win:Int?=nil,
                  lose:Int?=nil,
                  null:Int?=nil) {
        self._id = _id

        self.image = image
        self.admin = admin
        self.nom = nom
        self.discription = discription
        self.joueurs_id = joueurs_id
        self.point = point
        self.win = win
        self.lose = lose
        self.null = null
    }
    let _id:String?
    let image:String?
    let admin:adminModel?
    let nom:String?
    //var capacity: Int
    let discription:String?
    let joueurs_id:[joueurModel]?
    let point:Int?
    let win:Int?
    let lose:Int?
    let null:Int?
}
