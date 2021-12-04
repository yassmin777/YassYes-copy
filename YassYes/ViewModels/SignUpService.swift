//
//  SignUpService.swift
//  YassYes
//
//  Created by Mac-Mini_2021 on 27/11/2021.
//

/*import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif
import Alamofire

class SignUpService{
   
   static let shareinstance = SignUpService()
    func register(admin :adminModel){

    var semaphore = DispatchSemaphore (value: 0)

        let parameters = "{\r\n\"nom\":\""+admin.nom+"\",\r\n\"prenom\":\""+admin.prenom+"\",\r\n\"email\":\""+admin.email+"\",\r\n\"motdepasse\":\""+admin.motdepasse+"\",\r\n\"isProprietaireDestade\":"+admin.isProprietaireDestade+"}"
    let postData = parameters.data(using: .utf8)

    var request = URLRequest(url: URL(string: "http://localhost:3000/user")!,timeoutInterval: Double.infinity)
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
        
      semaphore.signal()
    }

    task.resume()
    semaphore.wait()

    }
   }
 */

