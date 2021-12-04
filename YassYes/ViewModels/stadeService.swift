//
//  stadeService.swift
//  YassYes
//
//  Created by Mac-Mini_2021 on 04/12/2021.
//

import Foundation
import Alamofire
import SwiftyJSON
class stadeService{
    static let shareInstence = stadeService()
    
    func addStade(stade : stadeModel,completionHandler:@escaping (Bool)->()){
        let headers: HTTPHeaders = [.contentType("application/json"),.authorization(bearerToken:(UserDefaults.standard.string(forKey: "token")!)) ]
        AF.request("http://localhost:3000/stade", method: .post, parameters: stade,encoder: JSONParameterEncoder.default, headers: headers ).response{ response in debugPrint(response)
            switch response.result{
            case .success(let data):
                do {
                    let json  = try JSONSerialization.jsonObject(with: data!, options: [])
                    print(json)
                    if response.response?.statusCode == 201{
                        completionHandler(true)
                    }else{
                        completionHandler(false)
                    }
                    
                } catch  {
                    print(error.localizedDescription)
                    completionHandler(false)
                    
                    
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }

}
