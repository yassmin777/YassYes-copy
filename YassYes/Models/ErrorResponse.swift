//
//  ErrorResponse.swift
//  YassYes
//
//  Created by Mac-Mini_2021 on 29/11/2021.
//

import Foundation

struct ErrorRespone: Decodable,LocalizedError{
    let reason: String
    var errorDescription: String? {return reason}
}

