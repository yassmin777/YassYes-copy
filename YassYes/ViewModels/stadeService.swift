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
/*
sb-3yz6i9021164@business.example.com
ATFhQDNX99_ktKL6xczfZsRsjUdMBR3_HmZTpeI4qFE6mpONojysTEaU2Nrvpgssk0Bv0k5z6lo6sC3c
EKytMlKIHQ9l6mRY0EYEp2eHXkbaYQl3OJGVWmAKE8XS2gFWKU_nfdzYw5oow0kLy_xLyeV5NBr8fqQw
 */
class stadeService{
    static let shareInstence = stadeService()
    
    func addstade(stade: stadeModel, uiImage: UIImage, completed: @escaping (Bool) -> Void ) {
        print("hi")
        let headers: HTTPHeaders = [.authorization(bearerToken:(UserDefaults.standard.string(forKey: "token")!))
]
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(uiImage.jpegData(compressionQuality: 0.5)!, withName: "image" , fileName: "image.jpeg", mimeType: "image/jpeg")
            
            let ParametersS = [ "nom": stade.nom!,
                                "lat": stade.lat!,
                                "lon": stade.lon!,
                                "discription": stade.discription!,
                                "num": stade.num!
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
            },to: Host+"/stade",
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
   
    func addLigueTostade(_id:String, ligues_id: String,completionHandler:@escaping (Bool)->()){
        let headers: HTTPHeaders = [.contentType("application/x-www-form-urlencoded"),.authorization(bearerToken:(UserDefaults.standard.string(forKey: "token")!)) ]
        AF.request(Host+"/stade/"+_id, method: .put ,parameters:[ "ligues_id":ligues_id] , headers: headers ).response{ response in
            switch response.result{
            case .success(let data):
                do {
                    let json  = try JSONSerialization.jsonObject(with: data!, options: [])
                    print(json)
                    if response.response?.statusCode == 201{
                        print("hhhhhh")
                        print(ligues_id)
                        print("hhhhhh")
                        print(_id)
                        //let jsonData = JSON(response.data!)
                        //let user = self.makeItemstade(jsonItem: jsonData)
                        completionHandler(true)

                        //print(user)
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
    func makeItemligue(jsonItem: JSON) -> ligueModel {
        //let isoDate = jsonItem["dateNaissance"]
        ligueModel(
            _id: jsonItem["_id"].stringValue,
            admin: makeItemAdmin(jsonItem: jsonItem["_id"]),
            nom: jsonItem["nom"].stringValue,
            discription: jsonItem["discription"].stringValue

        )
    }
    func makeItemstade(jsonItem: JSON) -> stadeModel {
        //let isoDate = jsonItem["dateNaissance"]
        stadeModel(
            _id: jsonItem["_id"].stringValue,
            admin: makeItemAdmin(jsonItem: jsonItem["_id"]),
            nom: jsonItem["nom"].stringValue,
            lat: jsonItem["lat"].doubleValue,
            lon: jsonItem["lon"].doubleValue

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


