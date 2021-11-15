//
//  ligue.swift
//  YassYes
//
//  Created by Mac-Mini-2021 on 13/11/2021.
//

import Foundation
struct Ligue:Codable{
    let photo:String?
    let nom:String
    let discription:String
    let equipe:[Equipe]
}
