//
//  stadeService.swift
//  YassYes
//
//  Created by Mac-Mini_2021 on 04/12/2021.
//
import Foundation
import Alamofire
import SwiftyJSON
import UIKit.UIImage

class stadeService{
    static let shareInstence = stadeService()
    /*
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
     */
   /* [
        "nom": stade.nom!,
        "lat": stade.lat!,
        "lon": stade.lon!,
        "discription": stade.discription!
        //"date": publication.date!,
        //"utilisateur": UserDefaults.standard.string(forKey: "userId")!
    ]
    for (key, value) in ParametersS {
        if let temp = value as? String {
        multipartFormData.append(temp.data(using: .utf8)!, withName: key)
        }
        if let temp = value as? Int {
        multipartFormData.append("(temp)".data(using: .utf8)!, withName: key)
        }
        if let temp = value as? Double{
            (data:"\(value)".data(usingEncoding: false)!, withName :key)
        }
        if let temp = value as? NSArray {
        temp.forEach({ element in
        let keyObj = key + "[]"
        if let string = element as? String {
        multipartFormData.append(string.data(using: .utf8)!, withName: keyObj)
        } else
        if let num = element as? Int {
        let value = "(num)"
        multipartFormData.append(value.data(using: .utf8)!, withName: keyObj)
        }
        })
        }
    }*/
    func addstade(stade: stadeModel, uiImage: UIImage, completed: @escaping (Bool) -> Void ) {
        print("hi")
        let headers: HTTPHeaders = [.authorization(bearerToken:(UserDefaults.standard.string(forKey: "token")!))
]
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(uiImage.jpegData(compressionQuality: 0.5)!, withName: "image" , fileName: "image.jpeg", mimeType: "image/jpeg")
            
            let ParametersS = [ "nom": stade.nom!,
                                "lat": stade.lat!,
                                "lon": stade.lon!,
                                "discription": stade.discription!
            ] as [String : Any]
            for (key, value) in ParametersS {
                if let temp = value as? String {
                    multipartFormData.append(temp.data(using: .utf8)!, withName: key)
                }
                if let temp = value as? Int {
                    multipartFormData.append("\(temp)".data(using: .utf8)!, withName: key)
                }
                if let temp = value as? Double {
                    multipartFormData.append("\(temp)".data(using: .utf8)!, withName: key)
                
                }
                
                print(multipartFormData)
            }
            },to: "http://localhost:3000/stade",
        method: .post,headers: headers)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    print("Success")
                    completed(true)
                case let .failure(error):
                    completed(false)
                    print(error)
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

