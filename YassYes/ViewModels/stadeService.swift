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
    func getAllstade(_id:String,completionHandler: @escaping (Bool, [stadeModel]?) -> Void ) {
        let headers: HTTPHeaders = [.contentType("application/json"),.authorization(bearerToken:(UserDefaults.standard.string(forKey: "token")!)) ]
        AF.request("http://localhost:3000/stade/my", method: .get,parameters:[ "_id":UserDefaults.standard.value(forKey: "_id")!] , headers: headers ).response{ response in
                switch response.result {
                case .success:
                    var stadess : [stadeModel]? = []
                    for singleJsonItem in JSON(response.data!)["stadess"] {
                        stadess!.append(self.makeItem(jsonItem: singleJsonItem.1))
                    }
                    completionHandler(true, stadess)
                case let .failure(error):
                    debugPrint(error)
                    completionHandler(false, nil)
                }
            }
    }
    func getstades(_id:String,completionHandler:@escaping (Bool,[stadeModel]?)->()){
        let headers: HTTPHeaders = [.contentType("application/json"),.authorization(bearerToken:(UserDefaults.standard.string(forKey: "token")!)) ]
        AF.request("http://localhost:3000/stade/my", method: .get,parameters:[ "_id":UserDefaults.standard.value(forKey: "_id")!] , headers: headers ).response{ response in
            switch response.result{
            case .success(let data):
                do {
                    let json  = try JSONSerialization.jsonObject(with: data!, options: [])
                    print(json)
                    if response.response?.statusCode == 200{
                        //let stade = try? JSON(data: response.data!)
                    
                        
                        var stades : [stadeModel]? = []
                        for singleJsonItem in JSON(response.data!) {
                            stades!.append(self.makeItem(jsonItem: singleJsonItem.1))
                        }
                        print(stades)
                        completionHandler(true,stades)

                    }else{
                        completionHandler(false,nil)
                    }
                    
                } catch  {
                    print(error.localizedDescription)
                    completionHandler(false,nil)
                    
                    
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }/*
    func getstades(_id:String,completionHandler:@escaping (Bool,[nom]?)->()){
        let headers: HTTPHeaders = [.contentType("application/json"),.authorization(bearerToken:(UserDefaults.standard.string(forKey: "token")!)) ]
        AF.request("http://localhost:3000/stade/my", method: .get,parameters:[ "_id":UserDefaults.standard.value(forKey: "_id")!] , headers: headers ).response{ response in
            switch response.result{
            case .success(let data):
                do {
                    let json  = try JSONSerialization.jsonObject(with: data!, options: [])
                    print(json)
                    if response.response?.statusCode == 200{
                        //let stade = try? JSON(data: response.data!)
                        let jsonData = JSON(response.data!)
                        let stade = self.makeItem(jsonItem: jsonData)
                        completionHandler(true,stade)

                        print(stade)
                    }else{
                        completionHandler(false,"nil")
                    }
                    
                } catch  {
                    print(error.localizedDescription)
                    completionHandler(false,"nil")
                    
                    
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }*/
    func makeItem(jsonItem: JSON) -> stadeModel {
        //let isoDate = jsonItem["dateNaissance"]
        stadeModel(
            _id: jsonItem["_id"].stringValue,
            //admin: makeItemAdmin(jsonItem: jsonItem["_id"]),
            nom: jsonItem["nom"].stringValue,
            lat: jsonItem["lat"].doubleValue,
            lon: jsonItem["lon"].doubleValue,
            discription: jsonItem["discription"].stringValue
            
        )
    }
    func makeItemAdmin(jsonItem: JSON) -> adminModel {
        //let isoDate = jsonItem["dateNaissance"]
        adminModel(
            _id: jsonItem["_id"].stringValue,
            nom: jsonItem["nom"].stringValue,
            prenom: jsonItem["prenom"].stringValue,
            email: jsonItem["email"].stringValue,
            motdepasse: jsonItem["motdepasse"].stringValue,
            isProprietaireDestade: jsonItem["isProprietaireDestade"].stringValue

        )
    }
}
