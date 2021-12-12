//
//  joueurModel.swift
//  YassYes
//
//  Created by Mac-Mini_2021 on 27/11/2021.
//

import Foundation
struct joueurModel{
    internal init(image:String?=nil,
                  _id: String?=nil,
                  admin: adminModel? = nil,
                  nom: String? = nil,
                  prenom : String? = nil,
                  age : String? = nil,
                  taille : String? = nil,
                  longueur : String? = nil,
                  num : String? = nil,
                  discription: String? = nil) {
        self.image = image
        self._id = _id
        self.admin = admin
        self.nom = nom
        self.prenom = prenom
        self.age = age
        self.taille = taille
        self.longueur = longueur
        self.num = num
        self.discription = discription
    }
    let image:String?
    let _id:String?
    let admin:adminModel?
    let nom:String?
    let prenom:String?
    let age:String?
    let taille:String?
    let longueur:String?
    let num:String?
    let discription:String?

}
