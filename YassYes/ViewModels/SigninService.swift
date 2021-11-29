//
//  SigninService.swift
//  YassYes
//
//  Created by Mac-Mini_2021 on 27/11/2021.
//

import Foundation

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

class SigninService{
    /*static let shareinstance = SigninService()

    func Signin(admin : adminModel)-> Bool{
        var status: Bool  = false

        var semaphore = DispatchSemaphore (value: 0)

        let parameters = "{\r\n    \"email\" : \""+admin.email+"\",\r\n    \"motdepasse\" : \""+admin.motdepasse+"\",\r\n    \"__v\":0\r\n}"
        let postData = parameters.data(using: .utf8)

        var request = URLRequest(url: URL(string: "http://localhost:3000/sifflet/api/auth/signin")!,timeoutInterval: Double.infinity)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        request.httpMethod = "POST"
        request.httpBody = postData

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
          guard let data = data else {
            print(String(describing: error))
            semaphore.signal()
            return
          }
        
          print(String(data: data, encoding: .utf8)!)
            /*if let jsonRes  = try? JSONSerialization.jsonObject(with: data, options:[] ) as? [String: Any]{
               print("probleme ici", jsonRes)
                if jsonRes["token"] != nil {
                   
                    
                    UserDefaults.standard.setValue(jsonRes["token"], forKey: "tokenConnexion")
                }
                if let reponse = jsonRes["admin"] as? [String: Any]{
                    for (key,value) in reponse{
                       // print("++++++++++",key,value)
                        UserDefaults.standard.setValue(value, forKey: key)
                        
                    }
                    UserDefaults.standard.setValue("", forKey: "password")
                }
            }
            print("hi")
            print(UserDefaults.standard.string(forKey: "accessToken"))
            print("hi")*/
            let jsonRes = try? JSONSerialization.jsonObject(with: data, options: [])as? [String:Any]
            print(jsonRes!)
            for (key,value) in jsonRes!{
                UserDefaults.standard.set(value, forKey: key)
            }
            print("hi")
            print(UserDefaults.standard.string(forKey: "accessToken"))
            print("hi")
            
            //Now get like this and use guard so that it will prevent your crash if value is nil.
            
          semaphore.signal()
        }

        task.resume()
        semaphore.wait()
        return status
    }
    func vefierToken() -> Int {
        var statu: Int = 0

        var semaphore = DispatchSemaphore (value: 0)

        var request = URLRequest(url: URL(string: "http://localhost:3000/sifflet/api/test/user")!,timeoutInterval: Double.infinity)
        request.addValue(UserDefaults.standard.string(forKey: "accessToken")!, forHTTPHeaderField: "x-access-token")

        request.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
          guard let data = data else {
            print(String(describing: error))
            semaphore.signal()
            return
          }
          print(String(data: data, encoding: .utf8)!)
          semaphore.signal()
        }

        task.resume()
        semaphore.wait()
        return statu
    }
     */
   
}
